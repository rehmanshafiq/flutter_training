import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/network_manager/repository.dart';
import 'package:flutter_training/state_management/image_picker_provider.dart';
import 'package:flutter_training/utils/app_strings.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagePickerProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
            title: const Text(
              AppStrings.multipart,
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: provider.pickImage,
                  child: provider.selectedImage == null
                      ? Container(
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 50),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(AppStrings.selectImage),
                  )
                      : Container(
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 50),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(provider.selectedImage!),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if(provider.selectedImage != null) {
                        provider.setLoading(true);
                        FormData formData = FormData.fromMap({
                          'file': await MultipartFile.fromFile(provider.selectedImage!.path, filename: provider.fileName)
                        });
                        Repository().uploadImage(formData).then((value) {
                          print('Image url: ${value.location}');
                          provider.setLoading(false);
                        }).onError((error, stackTrace){
                          print('Error: ${error.toString()}');
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Plz select image")));
                      }
                    },
                    child: provider.loading
                        ? const CircularProgressIndicator()
                        : Text(AppStrings.upload),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
