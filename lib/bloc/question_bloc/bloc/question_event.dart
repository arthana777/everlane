import 'package:equatable/equatable.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class UpdateQuestion extends QuestionEvent {
  final Map<String, dynamic> data;
  UpdateQuestion({required this.data});

  @override
  List<Object> get props => [data];
}
