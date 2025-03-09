import 'package:flutter/material.dart';
import 'package:flutter_training/widgets/text_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_router/route_strings.dart';
import '../components/designer_section.dart';
import '../components/interior_section.dart';
import '../components/toolbar.dart';
import '../state_management/firebase_remote_provider.dart';

class CardInterior extends StatelessWidget {
  const CardInterior({super.key});

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
            Consumer<RemoteConfigProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final categories = provider.categories ?? [];
                if (categories.isEmpty) {
                  return const Center(child: Text("No categories available"));
                }
                return CategoryList(categories: categories);
              },
            ),
            Expanded(
              child: ListView(
                children: [
                  buildInteriorList(),
                  const SizedBox(height: 20),
                  designNearList(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Category List with selection functionality
class CategoryList extends StatefulWidget {
  final List<String> categories;
  const CategoryList({super.key, required this.categories});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              context.push(AppRouteConstants.detail);
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: Center(
                child: MyText(
                  widget.categories[index],
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
