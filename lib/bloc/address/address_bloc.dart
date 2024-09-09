import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/datasources/useraddress_datasourse.dart';
import '../../data/models/addressmodel.dart';
import '../../data/models/disastermodel.dart';
import '../../data/models/mydonationsmodel.dart';
import '../../data/models/pickupmodel.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    UseraddressDatasourse useraddressDatasourse=UseraddressDatasourse();
    on<FetchUserAddresses>((event, emit) async {
      List<UserAddress> list=[];
      emit(AddressLoading());
      print("mnbvcxx");
      try {
        final result = await useraddressDatasourse.getAddress();

        list=result;
        print("@D@D@D${list.length}");
        if (list.isEmpty) {
          emit(AddressLoaded(userAddresses: []));  // Emit an empty list
        } else {
          emit(AddressLoaded(userAddresses: result));
        }
        // if(list.isNotEmpty){
        //   emit(AddressLoaded(userAddresses: []));
        // }
      } catch (e) {
        print("kikikikkiki");
        emit(AddressError(message: e.toString()));
      }
    });


    on<CreateAddress>((event,emit) async {
      emit(AddressLoading());
      try {
        final addresses = await useraddressDatasourse.createAddress(
            event.mobile, event.pincode, event.locality, event.address, event.city,
            event.state, event.landmark, event.isDefault, event.isActive, event.isDeleted);
        print("object${addresses}");
        if(addresses=="success"){
          emit(AddressCreationSuccess());
        }
        else{
          emit(AddressError(message:  e.toString(),));
        }
      } catch (e) {
        emit(AddressError( message: e.toString(),));
      }
    });

    on<DeleteAddress>((event, emit) async {
      emit((AddressLoading()));
      try {
        final deleteditems = await useraddressDatasourse.DeleteAddress(event.addressId);
        print("deleteditems: $deleteditems");

        if (deleteditems == "success") {
          emit(DeleteAdresssuccess(event.addressId));  // Simplified success state
        } else {
          emit(AddressError(message: e.toString(),));  // Emitting the failure with the message
        }
      } catch (e) {
        emit(AddressError( message: e.toString(),));
      }
    });

    on<DisasterReg>((event,emit) async {
      emit(AddressLoading());
      try {
        final addresses = await useraddressDatasourse.DisasterReg(
             event.name,
            event.adhar, event.location, event.description,
            event.requiredKidsDresses,event.requiredMenDresses,event.requiredWomenDresses);
        print("object${addresses}");
        if(addresses=="success"){
          emit(DisasteregSuccess());
        }
        else{
          emit(AddressError(message:  e.toString(),));
        }
      } catch (e) {
        emit(AddressError( message: e.toString(),));
      }
    });

    on<FetchDisaster>((event, emit) async {
      List<Disaster> list=[];
      emit(AddressLoading());
      print("mnbvcxx");
      try {
        final result = await useraddressDatasourse.getDisasterlist();

        list=result;
        print("@D@D@D${list.length}");
        if(list.isNotEmpty){
          emit(DisasterLoaded(result));
        }
      } catch (e) {
        print("kikikikkiki");
        emit(AddressError(message: e.toString()));
      }
    });

    on<uploadclothes>((event,emit) async {
      emit(AddressLoading());
      try {
        final addresses = await useraddressDatasourse.uploadCloths(event.disasterId,
          event.images,event.men??0,event.women??0,event.kids??0,event.pickup??0);
        print("disaster id in bloc ${event.disasterId}");
        print("adressesss${addresses}");
        if(addresses=="success"){
          emit(uploadclothesuccess());
        }
        else{
          emit(AddressError(message:  e.toString(),));
        }
      } catch (e) {
        emit(AddressError( message: e.toString(),));
      }
    });

    on<Fetchpickuplocations>((event, emit) async {
      List<PickupLocation> list=[];
      emit(Pickuploading());
      print("mnbvcxx");
      try {
        final result = await useraddressDatasourse.getPickuplocations();

        list=result;
        print("@D@D@D${list.length}");
        if (list.isNotEmpty) {
          emit(Pickuploaded(pickuplocations: list));  // Emit an empty list
        } else {
          emit(Pickuploaded(pickuplocations: []));
        }
        // if(list.isNotEmpty){
        //   emit(AddressLoaded(userAddresses: []));
        // }
      } catch (e) {
        print("kikikikkiki");
        emit(PickupError(message: e.toString()));
      }
    });

    on<fetchMydonations>((event, emit) async {
      List<Donation> list=[];
      emit(MydonationLoading());
      print("mnbvcxx");
      try {
        final result = await useraddressDatasourse.getmydonations();

        list=result;
        print("@D@D@D${list.length}");
        if(list.isNotEmpty){
          emit(MydonationLoaded(mydonations: result));
        }
      } catch (e) {
        print("kikikikkiki");
        emit(MydonationError(message: e.toString()));
      }
    });

    on<fetchmyRegistrations>((event, emit) async {
      List<Disaster> list=[];
      emit(MyRegistarionLoading());
      print("mnbvcxx");
      try {
        final result = await useraddressDatasourse.getmyregistrations();

        list=result;
        print("@D@D@D${list.length}");
        if(list.isNotEmpty){
          emit(MyRegistrationLoaded(myRegistrations: result));
        }
      } catch (e) {
        print("kikikikkiki");
        emit(MyRegistrationError(message: e.toString()));
      }
    });

  }
}
