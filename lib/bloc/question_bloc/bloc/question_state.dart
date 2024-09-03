abstract class QuestionState {}

class QstInitial extends QuestionState {}

class QuestionLoading extends QuestionState {}

class QuestionUpdated extends QuestionState {}

class QuestionError extends QuestionState {
  final String message;

  QuestionError(this.message);
}
