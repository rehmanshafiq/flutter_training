import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/network_manager/repository.dart';
import '../models/create_job_model.dart';

class PostJobApiCallCubit extends Cubit<ApiCallState> {
  PostJobApiCallCubit() : super(ApiCallInitial());

  final Repository _repository = Repository();

  Future<void> postJob(String name, String job) async {
    emit(ApiCallLoading());

    try {
      Map<String, dynamic> params = {
        "name": name,
        "job": job,
      };
      final createdJob = await _repository.postJobApi(params);
      emit(ApiCallSuccess(createdJob));
      print("Id: ${createdJob.id}, Name: ${createdJob.name}, Job: ${createdJob.job}");
    } catch (error) {
      emit(ApiCallError(error.toString()));
      print('Error: ${error.toString()}');
    }
  }
}


abstract class ApiCallState {}

class ApiCallInitial extends ApiCallState {}

class ApiCallLoading extends ApiCallState {}

class ApiCallSuccess extends ApiCallState {
  final CreateJobModel createdJob;

  ApiCallSuccess(this.createdJob);
}

class ApiCallError extends ApiCallState {
  final String error;

  ApiCallError(this.error);
}