import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

import '../models/InteriorTheme.dart';

class RemoteConfigProvider extends ChangeNotifier {

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<String>? _categories = [];
  List<String>? get categories => _categories;

  // List<Map<String, String>> themes = [];
  List<InteriorTheme> themes = [];


  RemoteConfigProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration.zero));
    await _fetchConfig();
  }

  Future<void> _fetchConfig() async {
    try {
      await _remoteConfig.fetchAndActivate();

      String categoriesStr = _remoteConfig.getString("categories_list");
      if (categoriesStr.isNotEmpty) {
        Map<String, dynamic> categoriesMap = jsonDecode(categoriesStr);
        _categories = List<String>.from(categoriesMap['my_strings']);
      } else {
        _categories = []; // If empty, set default empty list
      }

      // Fetch themes
      String themesJson = _remoteConfig.getString('interior_themes');
      debugPrint("Themes JSON: $themesJson");

      if (themesJson.isNotEmpty) {
        final decodedData = jsonDecode(themesJson) as Map<String, dynamic>;

        themes = (decodedData["themes"] as List<dynamic>)
            .map((theme) => InteriorTheme.fromJson(theme))
            .toList();

        debugPrint("Parsed Themes: $themes");
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching remote config: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

}