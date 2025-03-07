import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_training/widgets/text_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isArabic = false;

  // @override
  // void initState() {
  //   super.initState();
  //   isArabic = context.locale.languageCode == 'ar';
  // }

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
      appBar: AppBar(
        title: MyText('language'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              'hello',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("English"),
                Switch(
                  value: isArabic,
                  onChanged: _toggleLanguage,
                ),
                Text("العربية"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
