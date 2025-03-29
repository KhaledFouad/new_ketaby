import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/core/utils/app_constants.dart';
import 'package:new_ketaby/core/utils/app_styles.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colors.teal,
    unselectedWidgetColor: AppColors.grey,
    textTheme: GoogleFonts.montserratTextTheme(),
    primaryColor: AppColors.primaryColor,
    //primarySwatch: MaterialColor(0xff673ab7, color),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      color: Colors.teal,
      elevation: 0,
      systemOverlayStyle: AppConstants.systemUiOverlayStyleLight,
      titleTextStyle: AppStyles.textStyle25,
      centerTitle: true,
    ),
  );
}
