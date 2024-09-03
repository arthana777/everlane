
abstract class EditprofileState {}

class UserProfileInitial extends EditprofileState {}

class UserProfileLoading extends EditprofileState {}

class UserProfileUpdated extends EditprofileState {

  
}

class UserProfileError extends EditprofileState {
  final String message;

  UserProfileError(this.message);
}
