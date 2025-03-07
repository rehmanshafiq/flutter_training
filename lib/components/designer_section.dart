import 'package:flutter/material.dart';
import '../utils/app_strings.dart';


Widget designNearList(BuildContext context) {

  List<String> imageUrls = [
    AppStrings.profileImagePath,
    AppStrings.profileImagePath,
    AppStrings.profileImagePath,
    AppStrings.profileImagePath,
    AppStrings.profileImagePath,
    AppStrings.profileImagePath,
  ];


  return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.designerHeading,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
            // style: TextStyle(
            //   fontSize: 20,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60, // Restrict ListView height to fit images
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return profileImage(imageUrls[index]);
              },
            ),
          ),
        ],
      )
  );
}

Widget profileImage(String imageUrl) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        imageUrl,
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      ),
    ),
  );
}