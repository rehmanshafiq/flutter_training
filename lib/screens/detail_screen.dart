import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/utils/app_strings.dart';
import '../state_management/image_picker_provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagePickerCubit(),
      child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
        builder: (context, state) {
          return PopScope(
            canPop: true,
            onPopInvoked: (didPop) {
              if (didPop) {
                context.read<ImagePickerCubit>().reset();
              }
            },
            child: Scaffold(
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
                      onTap: () {
                        context.read<ImagePickerCubit>().pickImage(); // Pick image
                      },
                      child: state is ImagePickerSuccess && state.selectedImage != null
                          ? Container(
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 50),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(state.selectedImage!),
                          ),
                        ),
                      )
                          : Container(
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 50),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(AppStrings.selectImage),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is ImagePickerLoading
                            ? null
                            : () async {
                          if (state is ImagePickerSuccess && state.selectedImage != null) {
                            await context.read<ImagePickerCubit>().uploadImage(); // Upload image
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(AppStrings.plzUpload)),
                            );
                          }
                        },
                        child: state is ImagePickerLoading
                            ? const CircularProgressIndicator()
                            : const Text(AppStrings.upload),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}