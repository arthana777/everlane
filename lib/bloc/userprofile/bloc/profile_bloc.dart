import 'package:everlane/bloc/userprofile/bloc/profile_event.dart';
import 'package:everlane/bloc/userprofile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/profileservice.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService profileService;

  ProfileBloc(this.profileService) : super(ProfileInitial()) {
    on<FetchUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final userProfile = await profileService.fetchUserProfile();
        emit(ProfileLoaded(userProfile));
      } catch (e) {
        emit(ProfileError('Failed to load profile: $e'));
      }
    });
  }
}
