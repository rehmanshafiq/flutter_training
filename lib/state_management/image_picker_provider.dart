import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  bool _loading = false;
  File? _selectedImage;
  String? _fileName;

  bool get loading => _loading;
  File? get selectedImage => _selectedImage;
  String? get fileName => _fileName;

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      _selectedImage = File(file.path);
      _fileName = file.name;
      notifyListeners();
    }
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
