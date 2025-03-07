import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_training/utils/app_strings.dart';
import 'package:flutter_training/widgets/text_widget.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isArabic = false;

  void _toggleLanguage(bool value) {
    Locale newLocale = !isArabic ? Locale('ar', '') : Locale('en', '');
    context.setLocale(newLocale);
    setState(() {
      isArabic = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              AppStrings.profileScreen,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.english),
                Switch(
                  value: isArabic,
                  onChanged: _toggleLanguage,
                ),
                Text(AppStrings.arabic),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
