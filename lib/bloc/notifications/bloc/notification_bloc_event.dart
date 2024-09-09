import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotifications extends NotificationEvent {}

abstract class DeletNotificationEvent extends Equatable {
  const DeletNotificationEvent();

  @override
  List<Object?> get props => [];
}

