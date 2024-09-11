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
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(FetchNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                Future.delayed(const Duration(seconds: 1));
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text(state.message)),
                // );
                context.read<NotificationBloc>().add(FetchNotifications());
              } else if (state is DeletNotificationError) {
                Fluttertoast.showToast(
                  backgroundColor: Colors.green,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.white,
                  msg: "Error${state.message}",
                );
                Future.delayed(const Duration(seconds: 1));
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('Error: ${state.message}')),
                // );
              }
            },
          ),
        ],
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150.w,
                        height: 150.h,
                        child: Image.network(
                          "https://i.pinimg.com/736x/95/8d/38/958d38c0173a46b9a6f4cdca074ccbb8.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("No Notification Yet!",
                          style: CustomFont().titleText),
                      SizedBox(
                        height: 11.h,
                      ),
                      Text(
                          textAlign: TextAlign.center,
                          "You have no notifications right now.\nCome back later..",
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontSize: 13.sp))
                    ],
                  ),
                ),
              );
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
                          padding: const EdgeInsets.only(top: 10),
                          child: Card(
                            child: SizedBox(
                              width: 60.w,
                              child: Center(
                                child: SlidableAction(
                                  padding: EdgeInsets.only(top: 30),
                                  borderRadius: BorderRadius.circular(10),
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
                      margin: EdgeInsets.only(left: 10, right: 10, top: 15).w,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0).r,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.notifications, color: Colors.white),
                          backgroundColor: CustomColor.primaryColor,
                        ),
                        title: Text(notification.verb ?? "No Title ",
                            style: CustomFont().titleText),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.description ?? "No Description",
                              style: CustomFont().subText,
                            ),
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
