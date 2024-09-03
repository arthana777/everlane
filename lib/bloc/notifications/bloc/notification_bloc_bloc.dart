import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/notification_service.dart';
import 'notification_bloc_event.dart';
import 'notification_bloc_state.dart';


class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationService notificationService;

  NotificationBloc({required this.notificationService}) : super(NotificationInitial()) {
    on<FetchNotifications>((event, emit) async {
      emit(NotificationLoading());
      try {
        final notifications = await notificationService.fetchNotifications();
        emit(NotificationLoaded(notifications: notifications));
      } catch (e) {
        emit(NotificationError(message: e.toString()));
      }
    });

    on<DeleteNotification>((event, emit) async {
      if (state is NotificationLoaded) {
        final currentState = state as NotificationLoaded;
        final updatedNotifications = List.of(currentState.notifications);
        updatedNotifications.removeWhere((notification) => notification?.id == event.id);

        emit(NotificationLoaded(notifications: updatedNotifications));

        try {
          await notificationService.deleteNotification(event.id);
        } catch (e) {
          emit(NotificationError(message: e.toString()));
          emit(NotificationLoaded(notifications: currentState.notifications)); // Restore previous state on error
        }
      }
    });
  }
}
