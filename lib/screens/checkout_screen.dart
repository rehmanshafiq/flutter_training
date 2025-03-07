import 'package:flutter/material.dart';
import 'package:flutter_training/utils/app_strings.dart';
import 'package:flutter_training/widgets/text_widget.dart';

class CheckoutScreen extends StatelessWidget {

  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: MyText(AppStrings.checkoutScreen, style: Theme.of(context).textTheme.displayMedium));
  }
}