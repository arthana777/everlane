part of 'address_bloc.dart';

@immutable
sealed class AddressEvent extends Equatable {}
class FetchUserAddresses extends AddressEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CreateAddress extends AddressEvent {
  final String mobile;
  final String pincode;
  final String locality;
  final String address;
  final String city;
  final String state;
  final String landmark;
  final bool isDefault;
  final bool isActive;
  final bool isDeleted;

   CreateAddress({
    required this.mobile,
    required this.pincode,
    required this.locality,
    required this.address,
    required this.city,
    required this.state,
    required this.landmark,
    required this.isDefault,
    required this.isActive,
    required this.isDeleted,
  });

  @override
  List<Object> get props => [mobile, pincode, locality, address, city, state, landmark, isDefault, isActive, isDeleted];
}
class DeleteAddress extends AddressEvent{

  final int addressId;
  DeleteAddress(this.addressId);
  @override
  List<Object> get props => [addressId];
}
class DisasterReg extends AddressEvent {
  final int? id;
  final String? firstName;
  final String name;
  final String adhar;
  final String location;
  final String description;
  final int requiredMenDresses;
  final int requiredWomenDresses;
  final int requiredKidsDresses;
  final int? user;
  final String landmark;


  DisasterReg( {
     this.id,
     this.firstName,
    required this.name,
    required this.adhar,
    required this.location,
    required this.description,
    required this.requiredMenDresses,
    required this.requiredWomenDresses,
    required this.requiredKidsDresses,
     this.user,
    required this.landmark,
  });

  @override
  List<Object> get props => [
    name,
    adhar,
    location,
    description,
    requiredMenDresses,
    requiredWomenDresses,
    requiredKidsDresses,
    landmark,

  ];
}

class FetchDisaster extends AddressEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}



class uploadclothes extends AddressEvent{
  @override
  final int disasterId;
  final int? men;
  final int? women;
  final int? kids;
  final int? pickup;

  final List<File> images;

  uploadclothes({required this.images, required this.disasterId, this.men,  this.women,  this.kids, this.pickup,});
  List<Object?> get props => [images, disasterId];

}

class Fetchpickuplocations extends AddressEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class fetchMydonations extends AddressEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}



class fetchmyRegistrations extends AddressEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


