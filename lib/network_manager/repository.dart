import 'package:flutter_training/models/create_job_model.dart';
import 'package:flutter_training/models/response_in_map.dart';
import 'package:flutter_training/models/upload_file_model.dart';
import 'package:flutter_training/network_manager/dio_helper.dart';
import '../utils/app_config_service.dart';

class Repository {

  static final DioHelper _dioHelper = DioHelper();
  static final AppConfigService appConfigService = AppConfigService();

  Future<ResponseInMapModel> getUserList () async {
    Map<String, dynamic> response = await _dioHelper.get(url: '${appConfigService.baseURLReqres}/api/users?page=2');
    return ResponseInMapModel.fromJson(response);
  }

  Future<CreateJobModel> postJobApi (Object requestBody) async {
    Map<String, dynamic> response = await _dioHelper.post(url: '${appConfigService.baseURLReqres}/api/users', requestBody: requestBody);
    return CreateJobModel.fromJson(response);
  }

  Future<UploadFileModel> uploadImage (Object requestBody) async{
    Map<String, dynamic> response = await _dioHelper.uploadFileMultiPart(
        url: '${appConfigService.multiPartURL}/api/v1/files/upload', requestBody: requestBody
    );
    return UploadFileModel.fromJson(response);
  }
}