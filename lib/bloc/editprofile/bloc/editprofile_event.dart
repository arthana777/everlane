import 'package:equatable/equatable.dart';

abstract class EditprofileEvent extends Equatable {
  const EditprofileEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserProfile extends EditprofileEvent {
  final Map<String, dynamic> updatedData;

  const UpdateUserProfile(this.updatedData);

  @override
  List<Object> get props => [updatedData];
}
