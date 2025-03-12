import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/models/response_in_map.dart';
import 'package:flutter_training/network_manager/repository.dart';

class ApiCallCubit extends Cubit<UserState> {
  final Repository _repository;

  ApiCallCubit(this._repository) : super(UserInit());

  Future<void> getData() async {
    emit(UserLoading());
    try {
      final responseInMapModel = await _repository.getUserList();
      emit(UserSuccess(responseInMapModel));
    } catch (error) {
      emit(UserFailure('Error fetching users: $error'));
    }
  }
}

abstract class UserState {}

class UserInit extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final ResponseInMapModel responseInMapModel;
  UserSuccess(this.responseInMapModel);
}

class UserFailure extends UserState {
  final String message;
  UserFailure(this.message);
}
