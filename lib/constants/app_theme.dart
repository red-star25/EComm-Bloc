import 'package:ecomm/constants/colors.dart';
import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.secondary,
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.buttonColor,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: 'ZillaSlab',
      fontSize: 40,
      color: AppColors.primaryTextColor,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontFamily: 'Ubuntu',
      color: AppColors.orangeTextColor,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      fontFamily: 'Ubuntu',
      color: AppColors.secondaryTextColor,
      fontSize: 16,
      wordSpacing: 1.2,
      height: 1.5,
    ),
    button: TextStyle(
      fontFamily: 'Ubuntu',
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
);
