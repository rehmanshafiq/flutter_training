import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/network_manager/repository.dart';
import 'package:flutter_training/utils/app_strings.dart';
import 'package:image_picker/image_picker.dart';

enum ImagePickerState { idle, loading, success, error }

class ImagePickerProvider extends ChangeNotifier {
  ImagePickerState _state = ImagePickerState.idle;
  File? _selectedImage;
  String? _fileName;
  String? _errorMessage;

  ImagePickerState get state => _state;
  File? get selectedImage => _selectedImage;
  String? get fileName => _fileName;
  String? get errorMessage => _errorMessage;

  Future<void> pickImage() async {
    _setState(ImagePickerState.loading);

    try {
      final imagePicker = ImagePicker();
      final file = await imagePicker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        _selectedImage = File(file.path);
        _fileName = file.name;
        _setState(ImagePickerState.success);
      } else {
        _errorMessage = AppStrings.noImageSelected;
        _setState(ImagePickerState.error);
      }
    } catch (e) {
      _errorMessage = "Error picking image: $e";
      _setState(ImagePickerState.error);
    }
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) {
      _errorMessage = AppStrings.firstSelectIMage;
      _setState(ImagePickerState.error);
      return;
    }

    _setState(ImagePickerState.loading);

    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(_selectedImage!.path, filename: _fileName),
      });

      final response = await Repository().uploadImage(formData);

      print('Image URL: ${response.location}');

      _setState(ImagePickerState.success);
    } catch (e) {
      _errorMessage = "Upload failed: $e";
      _setState(ImagePickerState.error);
    }
  }

  void _setState(ImagePickerState newState) {
    _state = newState;
    notifyListeners();
  }

  void reset() {
    _selectedImage = null;
    _fileName = null;
    _errorMessage = null;
    _setState(ImagePickerState.idle);
  }
}
