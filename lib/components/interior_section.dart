import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state_management/firebase_remote_config_cubit.dart';
import '../utils/app_strings.dart';
import '../widgets/text_widget.dart';

class InteriorList extends StatelessWidget {
  const InteriorList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
      builder: (context, state) {
        if (state is RemoteConfigLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RemoteConfigLoaded) {
          return SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.themes.length,
              itemBuilder: (context, index) {
                final theme = state.themes[index];
                return buildInteriorCard(
                  imagePath: theme.image,
                  title: theme.title,
                );
              },
            ),
          );
        } else if (state is RemoteConfigError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(AppStrings.noDataAvailable));
        }
      },
    );
  }
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
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 3,
                    ),
                  ),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
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