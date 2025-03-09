import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

class RemoteConfigProvider extends ChangeNotifier {

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<String>? _categories = [];
  List<String>? get categories => _categories;

  RemoteConfigProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(minutes: 2),
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

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching remote config: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

}