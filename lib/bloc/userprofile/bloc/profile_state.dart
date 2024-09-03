


import '../../../data/models/userprofile.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

// class ProfileLoad extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Userprofile  userProfile;
  ProfileLoaded(this.userProfile);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}