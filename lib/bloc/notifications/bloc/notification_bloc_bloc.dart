
import 'package:everlane/bloc/notifications/bloc/notification_bloc_event.dart';
import 'package:everlane/bloc/notifications/bloc/notification_bloc_state.dart';
import 'package:everlane/data/datasources/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationService notificationService;

  NotificationBloc({required this.notificationService})
      : super(NotificationInitial()) {
    on<FetchNotifications>((event, emit) async {
      emit(NotificationLoading());
      try {
        final notifications = await notificationService.fetchNotifications();
        emit(NotificationLoaded(notifications: notifications));
      } catch (e) {
        emit(NotificationError(message: e.toString()));
      }
    });
  }
}
