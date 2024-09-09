

import 'package:everlane/bloc/delet_notification/bloc/delet_notification_event.dart';
import 'package:everlane/bloc/delet_notification/bloc/delet_notification_state.dart';
import 'package:everlane/bloc/notifications/bloc/notification_bloc_event.dart';
import 'package:everlane/data/datasources/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeletNotificationBloc
    extends Bloc<DeletNotificationEvent, DeletNotificationState> {
  final NotificationService notificationService;

  DeletNotificationBloc({required this.notificationService})
      : super(DeletNotificationInitial()) {
    on<DeleteNotification>((event, emit) async {
      emit(DeletNotificationLoading());
      try {
        final message = await notificationService.deleteNotification(event.id);
        emit(DeletNotificationSuccess(message));
      } catch (e) {
        emit(DeletNotificationError(e.toString()));
      }
    });
  }
}
