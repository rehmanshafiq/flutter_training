import 'package:flutter_training/models/create_job_model.dart';
import 'package:flutter_training/models/response_in_map.dart';
import 'package:flutter_training/network_manager/dio_helper.dart';

class Repository {

  static final DioHelper _dioHelper = DioHelper();

  Future<ResponseInMapModel> getUserList () async {
    Map<String, dynamic> response = await _dioHelper.get(url: 'https://reqres.in/api/users?page=2');
    return ResponseInMapModel.fromJson(response);
  }

  Future<CreateJobModel> postJobApi (Object requestBody) async {
    Map<String, dynamic> response = await _dioHelper.post(url: 'https://reqres.in/api/users', requestBody: requestBody);
    return CreateJobModel.fromJson(response);
  }
}