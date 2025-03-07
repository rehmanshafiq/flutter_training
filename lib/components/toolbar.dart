import 'package:flutter/material.dart';
import 'package:flutter_training/widgets/text_widget.dart';
import '../utils//app_colors.dart';
import '../utils//app_strings.dart';

Container toolbarHeading(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 30),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            AppStrings.helloJackHeading,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Container(
            margin: EdgeInsets.only(top: 34),
            child: Icon(
              Icons.settings_display_sharp,
              color: AppColors.blackLabelColor,
              size: 30,
            ),
          ),
        ]),
  );
}