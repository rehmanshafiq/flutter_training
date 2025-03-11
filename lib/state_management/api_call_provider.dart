import 'package:flutter/material.dart';
import 'package:flutter_training/models/response_in_map.dart';
import 'package:flutter_training/network_manager/repository.dart';

import '../models/create_job_model.dart';

class ApiCallProvider extends ChangeNotifier {
  bool isLoading = true;
  ResponseInMapModel responseInMapModel = ResponseInMapModel();

  ApiCallProvider() {
    getData();
  }

  Future<void> getData() async {
    try {
      responseInMapModel = await Repository().getUserList();
    } catch (error) {
      print('Error fetching users: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  CreateJobModel? createdJob;

  Future<void> postJob(String name, String job) async {
    isLoading = true;
    notifyListeners(); // Notify UI that loading has started

    try {
      Map<String, dynamic> params = {
        "name": name,
        "job": job,
      };
      createdJob = await Repository().postJobApi(params);
      print("Id: ${createdJob?.id}, Name: ${createdJob?.name}, Job: ${createdJob?.job}");
    } catch (error) {
      print('Error: ${error.toString()}');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify UI to update state
    }
  }
}
