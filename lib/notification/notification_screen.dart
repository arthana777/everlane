
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


import '../bloc/notifications/bloc/notification_bloc_bloc.dart';
import '../bloc/notifications/bloc/notification_bloc_event.dart';
import '../bloc/notifications/bloc/notification_bloc_state.dart';
import '../widgets/customcolor.dart';
import '../widgets/customfont.dart';

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
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Notifications",
          style: CustomFont().appbarText,
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
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
                    motion: const ScrollMotion(),
                    children: [ 
                      
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        onPressed: (context) { 
                          _deleteNotification(context, notification.id!);
                        },

                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
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
                          style: CustomFont().subtitleText),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.description ?? "No Description",
                            style: CustomFont().bodyText,
                          ),
                          SizedBox(height: 4.0.h),
                          Text(notification.formatted_timestamp ?? "date time",
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
    );
  }

  void _deleteNotification(BuildContext context, int id) {
    context.read<NotificationBloc>().add(DeleteNotification(id));
  }
}
