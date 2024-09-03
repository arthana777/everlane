import 'package:equatable/equatable.dart';

import '../../../data/models/qstresult.dart';


abstract class QuestionResultState extends Equatable {
  const QuestionResultState();

  @override
  List<Object> get props => [];
}

class QuestionResultInitial extends QuestionResultState {}

class QuestionResultLoading extends QuestionResultState {}

class QuestionResultLoaded extends QuestionResultState {
  final List<Qstresult> qstresult;

  const QuestionResultLoaded(this.qstresult);

  @override
  List<Object> get props => [qstresult];
}

class QuestionResulError extends QuestionResultState {
  final String message;

  const QuestionResulError(this.message);

  @override
  List<Object> get props => [message];
}
