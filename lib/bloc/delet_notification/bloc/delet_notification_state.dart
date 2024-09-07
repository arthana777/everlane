
import 'package:equatable/equatable.dart';

abstract class DeletNotificationState extends Equatable {
  const DeletNotificationState();

  @override
  List<Object?> get props => [];
}

class DeletNotificationInitial extends DeletNotificationState {}



class DeletNotificationLoading extends DeletNotificationState {}

class DeletNotificationSuccess extends DeletNotificationState {
  final String message;

  const DeletNotificationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class DeletNotificationError extends DeletNotificationState {
  final String message;

  const DeletNotificationError(this.message);

  @override
  List<Object?> get props => [message];
}