import 'package:flutter/material.dart';
import 'app_colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ButtonSizes {
//   static double? buttonHeight = 45.sp; // last was 70
// }

class FontWeights {
  static FontWeight boldFontWeight = FontWeight.w800;
  static FontWeight fontWeight700 = FontWeight.w700;
  static FontWeight semiBoldFontWeight = FontWeight.w600;
  static FontWeight mediumFontWeight = FontWeight.w500;
  static FontWeight normalFontWeight = FontWeight.w400;
}

class AppFonts {
  static const TextStyle headingStyle = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle mediumHeadingStyle = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle buttonStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

// class FontSizes {
//   ///--------------Heading Font Size---------------
//   static double? splashHeadingLargeFont = 55.sp;
//   static double? maxHeadingLargeFont = 36.sp;
//   static double? headingLargeFont = 26.sp;
//   //26
//   static double? headingMediumFont = 23.sp;
//   //23
//   static double? headingSmallFont = 12.sp;
// //22
//   ///--------------Body Font Size---------------
//   static double? bodyMediumFont = 18.sp; //18
//   static double? bodySmallFont = 16.sp; //16
//   static double? get bodyExtraSmallFont => getFont(web: 16.sp, app: 14.sp);
//   static double? productVendorTitleSize = 23.sp;
//   static double? priceFontSize = 34.sp;
//   static double? welcomFontSize = 32.sp;
//   static double? bodyFont17 = 17.sp;
//   static double? bodyFont24 = 24.sp;
//
//   static double? bodyLargeFont = 20.sp;
//   static double? bodyExtraLargeFont = 28.sp;
//   //14
//
//   ///--------------Label font Size---------------
//   static double? labelExtraSmallFont = 12.sp;
//   //12
//   static double? tagsExtraSmallFont = 10.sp;
//
//   static double? labelSmallFont = 11.sp;
//
//   static getFont({required final double web, required final double app}) =>
//       kIsWeb ? web : app;
// }

