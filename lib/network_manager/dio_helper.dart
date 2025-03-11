import 'package:dio/dio.dart';
import 'package:flutter_training/network_manager/dio_interceptor.dart';

class DioHelper {

  Dio dio = getDio();

  Options options = Options(
    receiveDataWhenStatusError: true,
    contentType: "application/json",
    sendTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10)
  );

  Map<String, dynamic> headers = {"isAuthRequired": "Bearer token"};

  Future<dynamic> get ({required String url, bool isAuthRequired = false}) async {
    if(isAuthRequired) {
      options.headers = headers;
    }

    try {
      Response response = await dio.get(url, options: options);
      return response.data;
    } catch(error) {
      return null;
    }
  }

  Future<dynamic> post ({required String url, Object? requestBody, bool isAuthRequired = false}) async {
    if(isAuthRequired) {
      options.headers = headers;
    }

    try {
      Response response;
      if(requestBody == null) {
        response = await dio.post(url, options: options);
      } else {
        response = await dio.post(url, data: requestBody, options: options);
      }
      return response.data;
    } catch(error) {
      return null;
    }
  }

  Future<dynamic> put ({required String url, Object? requestBody, bool isAuthRequired = false}) async {
    if(isAuthRequired) {
      options.headers = headers;
    }

    try {
      Response response;
      if(requestBody == null) {
        response = await dio.put(url, options: options);
      } else {
        response = await dio.put(url, data: requestBody, options: options);
      }
      return response.data;
    } catch(error) {
      return null;
    }
  }

  Future<dynamic> patch ({required String url, Object? requestBody, bool isAuthRequired = false}) async {
    if(isAuthRequired) {
      options.headers = headers;
    }

    try {
      Response response;
      if(requestBody == null) {
        response = await dio.patch(url, options: options);
      } else {
        response = await dio.patch(url, data: requestBody, options: options);
      }
      return response.data;
    } catch(error) {
      return null;
    }
  }

  Future<dynamic> delete ({required String url, Object? requestBody, bool isAuthRequired = false}) async {
    if(isAuthRequired) {
      options.headers = headers;
    }

    try {
      Response response;
      if(requestBody == null) {
        response = await dio.delete(url, options: options);
      } else {
        response = await dio.delete(url, data: requestBody, options: options);
      }
      return response.data;
    } catch(error) {
      return null;
    }
  }

  Future<dynamic> uploadFileMultiPart ({required String url, required Object requestBody}) async {

    Options option = Options( headers: { "Content-Type":"multipart/form-data" });

    try {
      Response response = await dio.post(url, data: requestBody, options: option);;
      return response.data;
    } catch(error) {
      return null;
    }
  }

}