import 'package:flutter/material.dart';
import 'package:flutter_training/state_management/image_picker_provider.dart';
import 'package:flutter_training/utils/app_strings.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          Provider.of<ImagePickerProvider>(context, listen: false).reset();
        }
      },
      child: Consumer<ImagePickerProvider>(
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
                      onPressed: provider.state == ImagePickerState.loading
                          ? null
                          : () async {
                        if (provider.selectedImage != null) {
                          await provider.uploadImage();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(AppStrings.plzUpload)));
                        }
                      },
                      child: provider.state == ImagePickerState.loading
                          ? const CircularProgressIndicator()
                          : Text(AppStrings.upload),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
