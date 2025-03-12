import 'package:get_storage/get_storage.dart';

class AppConfigService {
  late final String baseURLReqres;
  late final String multiPartURL;

  AppConfigService() {
    baseURLReqres = GetStorage().read("reqres_base_url");
    multiPartURL = GetStorage().read("multipart_base_url");
  }
}
