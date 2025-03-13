import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../models/InteriorTheme.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final _storage = GetStorage();

  RemoteConfigCubit() : super(RemoteConfigInitial()) {
    _initialize();
  }

  Future<void> _initialize() async {
    emit(RemoteConfigLoading()); // Emit loading state
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(minutes: 1),
      minimumFetchInterval: Duration.zero,
    ));
    await _fetchConfig();
  }

  Future<void> _fetchConfig() async {
    try {
      await _remoteConfig.fetchAndActivate();

      // Fetch categories
      String categoriesStr = _remoteConfig.getString("categories_list");
      List<String>? categories = [];
      if (categoriesStr.isNotEmpty) {
        Map<String, dynamic> categoriesMap = jsonDecode(categoriesStr);
        categories = List<String>.from(categoriesMap['my_strings']);
      }

      // Fetch themes
      String themesJson = _remoteConfig.getString('interior_themes');
      List<InteriorTheme> themes = [];
      if (themesJson.isNotEmpty) {
        final decodedData = jsonDecode(themesJson) as Map<String, dynamic>;
        themes = (decodedData["themes"] as List<dynamic>)
            .map((theme) => InteriorTheme.fromJson(theme))
            .toList();
      }

      // Fetch base URLs
      String baseUrlsJson = _remoteConfig.getString("base_urls");
      String? reqresBaseUrl;
      String? multipartBaseUrl;
      if (baseUrlsJson.isNotEmpty) {
        final decodedBaseUrls = jsonDecode(baseUrlsJson) as Map<String, dynamic>;
        reqresBaseUrl = decodedBaseUrls["reqres_base_url"];
        multipartBaseUrl = decodedBaseUrls["multipart_base_url"];

        _storage.write("reqres_base_url", reqresBaseUrl);
        _storage.write("multipart_base_url", multipartBaseUrl);
      }

      // Emit loaded state
      emit(RemoteConfigLoaded(
        categories: categories,
        themes: themes,
        reqresBaseUrl: reqresBaseUrl,
        multipartBaseUrl: multipartBaseUrl,
      ));
    } catch (e) {
      // Emit error state
      emit(RemoteConfigError("Error fetching remote config: $e"));
    }
  }
}

abstract class RemoteConfigState {}

class RemoteConfigInitial extends RemoteConfigState {}

class RemoteConfigLoading extends RemoteConfigState {}

class RemoteConfigLoaded extends RemoteConfigState {
  final List<String>? categories;
  final List<InteriorTheme> themes;
  final String? reqresBaseUrl;
  final String? multipartBaseUrl;

  RemoteConfigLoaded({
    required this.categories,
    required this.themes,
    required this.reqresBaseUrl,
    required this.multipartBaseUrl,
  });
}

class RemoteConfigError extends RemoteConfigState {
  final String message;

  RemoteConfigError(this.message);
}