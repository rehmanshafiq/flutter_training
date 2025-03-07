import 'package:flutter/material.dart';
import 'package:flutter_training/widgets/text_widget.dart';
import 'package:go_router/go_router.dart';
import '../app_router/route_strings.dart';
import '../components/designer_section.dart';
import '../components/interior_section.dart';
import '../components/toolbar.dart';
import '../utils//app_strings.dart';

class CardInterior extends StatefulWidget {
  const CardInterior({super.key});

  @override
  _CardInteriorState createState() => _CardInteriorState();
}

class _CardInteriorState extends State<CardInterior> {

  int selectedIndex = 0;

  final List<String> categories = [
    AppStrings.interior, AppStrings.sofa, AppStrings.chairs, AppStrings.lamp
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            toolbarHeading(context),
            const SizedBox(height: 20),
            buildCategoryList(),
            Expanded(
                child: ListView(
                  children: [
                    buildInteriorList(),
                    const SizedBox(height: 20,),
                    designNearList(context),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }


  /// Horizontal Scrollable Category List
  Widget buildCategoryList() {
    return SizedBox(
      height: 50, // Fixed height for the category list
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Makes it scrollable horizontally
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              context.push(AppRouteConstants.detail);
              setState(() {
                selectedIndex = index; // Update selection
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: isSelected ? Border.all(color: Colors.grey, width: 2) : Border.all(color: Colors.grey, width: 2),
              ),
              child: Center(
                child: MyText(
                  categories[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}