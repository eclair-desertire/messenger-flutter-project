import 'package:flutter/material.dart';

abstract final class AppColors {}

abstract class AppIcons {
  static const String attach = "assets/icons/attach_icon.svg";
  static const String audio = "assets/icons/audio_icon.svg";
  static const String unread = "assets/icons/unread.svg";
  static const String read = "assets/icons/read.svg";
  static const String search = "assets/icons/search_icon.svg";
}

extension SizedBoxExtension on int {
  SizedBox get h => SizedBox(height: toDouble());

  SizedBox get w => SizedBox(width: toDouble());
}

final lightTheme = ThemeData(
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  dividerColor: Colors.white24,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.w600,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffEDF2F6)),
  useMaterial3: true,
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
  ),
);
