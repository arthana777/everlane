import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotifications extends NotificationEvent {}
class DeleteNotification extends NotificationEvent {
  final int id;

  DeleteNotification(this.id);
}