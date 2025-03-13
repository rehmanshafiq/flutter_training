import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_training/network_manager/repository.dart';
import 'package:flutter_training/utils/app_strings.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerInitial());

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  String? _fileName;

  Future<void> pickImage() async {
    emit(ImagePickerLoading());

    try {
      final file = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        _selectedImage = File(file.path);
        _fileName = file.name;
        emit(ImagePickerSuccess(selectedImage: _selectedImage, fileName: _fileName));
      } else {
        emit(ImagePickerError(AppStrings.noImageSelected));
      }
    } catch (e) {
      emit(ImagePickerError("Error picking image: $e"));
    }
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) {
      emit(ImagePickerError(AppStrings.firstSelectIMage));
      return;
    }

    emit(ImagePickerLoading());

    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(_selectedImage!.path, filename: _fileName),
      });

      final response = await Repository().uploadImage(formData);

      print('Image URL: ${response.location}');

      emit(ImagePickerSuccess(selectedImage: _selectedImage, fileName: _fileName));
    } catch (e) {
      emit(ImagePickerError("Upload failed: $e"));
    }
  }

  void reset() {
    _selectedImage = null;
    _fileName = null;
    emit(ImagePickerInitial());
  }
}


abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerLoading extends ImagePickerState {}

class ImagePickerSuccess extends ImagePickerState {
  final File? selectedImage;
  final String? fileName;

  ImagePickerSuccess({this.selectedImage, this.fileName});
}

class ImagePickerError extends ImagePickerState {
  final String errorMessage;

  ImagePickerError(this.errorMessage);
}