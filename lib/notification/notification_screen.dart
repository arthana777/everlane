import 'package:everlane/bloc/delet_notification/bloc/delet_notification_bloc.dart';
import 'package:everlane/bloc/delet_notification/bloc/delet_notification_event.dart';
import 'package:everlane/bloc/delet_notification/bloc/delet_notification_state.dart';
import 'package:everlane/bloc/notifications/bloc/notification_bloc_bloc.dart';
import 'package:everlane/bloc/notifications/bloc/notification_bloc_event.dart';
import 'package:everlane/bloc/notifications/bloc/notification_bloc_state.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<NotificationBloc>().add(FetchNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Notifications",
          style: CustomFont().appbarText,
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeletNotificationBloc, DeletNotificationState>(
            listener: (context, state) {
              if (state is DeletNotificationSuccess) {
                Fluttertoast.showToast(
                  backgroundColor: Colors.green,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.white,
                  msg: "${state.message}",
                );
                context.read<NotificationBloc>().add(FetchNotifications());
              } else if (state is DeletNotificationError) {
                Fluttertoast.showToast(
                  backgroundColor: Colors.red,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.white,
                  msg: "Error: ${state.message}",
                );
              }
            },
          ),
        ],
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationLoaded) {
              return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];
                  return Slidable(
                    key: ValueKey(notification.id),
                    endActionPane: ActionPane(
                      extentRatio: 0.2,
                      motion: const ScrollMotion(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10).h,
                          child: Card(
                            child: SizedBox(
                              width: 60.w,
                              child: Center(
                                child: SlidableAction(
                                  padding: const EdgeInsets.only(top: 30).h,
                                  borderRadius: BorderRadius.circular(10).w,
                                  onPressed: (context) {
                                    _deleteNotification(
                                        context, notification.id!);
                                  },
                                  backgroundColor: CustomColor.primaryColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: '',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0).r,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.notifications, color: Colors.white),
                          backgroundColor: CustomColor.primaryColor,
                        ),
                        title: Text(notification.verb ?? "No Title",
                            style: CustomFont().titleText),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notification.description ?? "No Description",
                                style: CustomFont().subText),
                            SizedBox(height: 4.0.h),
                            Text(
                                notification.formatted_timestamp ?? "date time",
                                style: CustomFont().subtitleText),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is NotificationEmpty) {
              return const Center(child: Text("No notifications available"));
            } else if (state is NotificationError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text("No notifications available"));
            }
          },
        ),
      ),
    );
  }

  void _deleteNotification(BuildContext context, int id) {
    context.read<DeletNotificationBloc>().add(DeleteNotification(id));
  }
}
