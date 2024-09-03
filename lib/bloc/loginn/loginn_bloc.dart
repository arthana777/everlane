import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import '../../data/datasources/login_datasource.dart';

part 'loginn_event.dart';
part 'loginn_state.dart';

class LoginnBloc extends Bloc<LoginnEvent, LoginnState> {
  LoginnBloc() : super(LoginnInitial()) {
    Apiservices datas = Apiservices();
    on<LoginButtonEvent>((event, emit) async {
      emit(LoginnLoading());
      try {
        final categories = await datas.getdata(event.username,event.password);
        if(categories=="success"){
          emit(LoginnSuccess());
        }
        else{
          emit(LoginnFailure());
        }
      } catch (e) {
        emit(LoginnFailure());
      }
    });
  }
}
