import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MyText extends StatelessWidget {
  final String textKey;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const MyText(
      this.textKey, {
        super.key,
        this.style,
        this.textAlign,
        this.maxLines,
        this.overflow,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      textKey.tr(), // Translation function
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
