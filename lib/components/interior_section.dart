import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/firebase_remote_provider.dart';
import '../widgets/text_widget.dart';

Widget buildInteriorList() {
  return Consumer<RemoteConfigProvider>(
    builder: (context, provider, child) {
      if (provider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (provider.themes.isEmpty) {
        return const Center(child: Text("No interior themes available"));
      }

      return SizedBox(
        height: 240, // Adjusted to fit the card design
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.themes.length,
          itemBuilder: (context, index) {
            final theme = provider.themes[index];
            return buildInteriorCard(
              imagePath: theme.image,
              title: theme.title,
            );
          },
        ),
      );
    },
  );
}

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
          child: CachedNetworkImage(
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
            imageUrl: imagePath,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                  child: SizedBox(
                    width: 30, // Set the desired width
                    height: 30, // Set the desired height
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 3,
                    ),
                  ),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
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
