import 'package:equatable/equatable.dart';

abstract class QuestionResultEvent extends Equatable {
  const QuestionResultEvent();

  @override
  List<Object> get props => [];
}

class FetchProduct extends QuestionResultEvent {}
