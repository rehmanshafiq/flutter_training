import 'package:flutter/material.dart';
import 'package:flutter_training/utils/app_strings.dart';
import 'package:flutter_training/widgets/text_widget.dart';

class SearchScreen extends StatelessWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: MyText(AppStrings.searchScreen, style: Theme.of(context).textTheme.displayMedium));
  }
}