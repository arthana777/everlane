part of 'loginn_bloc.dart';

@immutable
sealed class LoginnState {}

final class LoginnInitial extends LoginnState {}

final class LoginnLoading extends LoginnState {}

final class LoginnSuccess extends LoginnState {

}

final class LoginnFailure extends LoginnState {}
