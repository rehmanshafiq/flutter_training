import 'package:flutter/material.dart';
import 'package:flutter_training/widgets/text_widget.dart';
import '../utils/app_strings.dart';
import '../models/Interior.dart';

final List<Interior> interiors = [
  Interior(image: AppStrings.cardImagePath, title: AppStrings.cardHeading1),
  Interior(image: AppStrings.cardImagePath, title: AppStrings.cardHeading2),
  Interior(image: AppStrings.cardImagePath, title: AppStrings.cardHeading3),
];

Widget buildInteriorList() {
  return SizedBox(
    height: 240, // Adjusted to fit the card design
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: interiors.length,
      itemBuilder: (context, index) {
        return buildInteriorCard(
          imagePath: interiors[index].image,
          title: interiors[index].title,
        );
      },
    ),
  );
}

/// Interior Card UI
Widget buildInteriorCard({required String imagePath, required String title}) {
  return Container(
    width: 180, // Adjust card width
    margin: const EdgeInsets.only(right: 15, bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 4),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: MyText(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}