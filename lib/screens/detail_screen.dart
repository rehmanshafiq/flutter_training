import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_training/utils/app_strings.dart';
import 'package:image_picker/image_picker.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  bool loading = false;
  File? selectedImage;
  String? fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Text(AppStrings.multipart, style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                  if(file != null) {
                    selectedImage = File(file.path);
                    fileName = file.name;
                    setState(() {});
                  }
                },
                child: selectedImage == null ? Container(
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 50),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(AppStrings.selectImage),
                ): Container(
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 50),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(selectedImage!)
                    )
                  ),
                )
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    child: loading? const CircularProgressIndicator(): Text(AppStrings.upload),
                ),
              )
            ],
          ),
      ),
    );
  }
}