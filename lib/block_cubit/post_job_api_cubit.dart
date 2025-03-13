import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/network_manager/repository.dart';
import '../models/create_job_model.dart';

class PostJobApiCubit extends Cubit<JobApiState> {
  PostJobApiCubit() : super(JobApiInitial());

  final Repository _repository = Repository();

  Future<void> postJob(String name, String job) async {
    emit(JobApiLoading());

    try {
      Map<String, dynamic> params = {
        "name": name,
        "job": job,
      };
      final createdJob = await _repository.postJobApi(params);
      emit(JobApiSuccess(createdJob));
      print("Id: ${createdJob.id}, Name: ${createdJob.name}, Job: ${createdJob.job}");
    } catch (error) {
      emit(JobApiError(error.toString()));
      print('Error: ${error.toString()}');
    }
  }
}


abstract class JobApiState {}

class JobApiInitial extends JobApiState {}

class JobApiLoading extends JobApiState {}

class JobApiSuccess extends JobApiState {
  final CreateJobModel createdJob;

  JobApiSuccess(this.createdJob);
}

class JobApiError extends JobApiState {
  final String error;

  JobApiError(this.error);
}