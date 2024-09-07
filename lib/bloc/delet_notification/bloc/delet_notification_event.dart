import 'package:everlane/bloc/notifications/bloc/notification_bloc_event.dart';

class DeleteNotification extends DeletNotificationEvent {
  final int id;

  const DeleteNotification(this.id);

  @override
  List<Object?> get props => [id];
}
