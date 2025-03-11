import 'package:flutter/material.dart';
import 'package:flutter_training/utils/app_strings.dart';
import 'package:flutter_training/widgets/text_widget.dart';

class DetailScreen extends StatelessWidget {

  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: MyText(AppStrings.detailScreen, style: Theme.of(context).textTheme.displayMedium)
      ),
    );
  }
}