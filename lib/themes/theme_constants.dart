// ignore_for_file: depreecated_member_use, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryLight = Color(0xff3C4FFA);
const primaryVariantLight = Color(0xff1363DF);
const secondaryLight = Color(0xff171A1D);
const secondaryVariantLight = Color(0xffDFF6FF);
const tertiaryLight = Color(0xffffffff);

const surfaceLight = Color(0xfffcfcfc);
const backgroundLight = Color.fromARGB(255, 220, 220, 220);
const onBackgroundLight = Color(0xff4B4B4B);
const onSurfaceLight = Color(0xff848484);

const primaryContainerLight = Color(0xffd9d9d9);
const onPrimaryContainerLight = Color(0xffD3D3D3);
const onSurfaceVariantLight = Color(0xffEFEFEF);
const secondaryContainerLight = Color(0xff676767);

const shadowLight = Color.fromRGBO(0, 0, 0, 0.16);

ThemeData lightTheme() => ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
        primary: primaryLight,
        primaryVariant: primaryVariantLight,
        onPrimary: Colors.white,
        secondary: secondaryLight,
        secondaryVariant: secondaryVariantLight,
        onSecondary: Colors.white,
        tertiary: tertiaryLight,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.white,
        background: backgroundLight,
        onBackground: onBackgroundLight,
        surfaceVariant: const Color(0x00EEEEEE),
        outline: onBackgroundLight.withOpacity(.6),
        surface: surfaceLight,
        onSurface: onSurfaceLight,
        shadow: shadowLight,
        onSurfaceVariant: onSurfaceVariantLight,
        primaryContainer: primaryContainerLight,
        onPrimaryContainer: onPrimaryContainerLight,
        secondaryContainer: secondaryContainerLight,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: surfaceLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 47,
            ),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryLight,
        centerTitle: true,
        // toolbarHeight: 57,
        shadowColor: Color(0x1E000000),
        elevation: 3,
      ),
      buttonTheme: const ButtonThemeData(),
      iconTheme: const IconThemeData(
        opacity: 1,
        color: Colors.white,
        size: 30.0,
      ),
      fontFamily: GoogleFonts.arimo().fontFamily,
      scaffoldBackgroundColor: backgroundLight,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: primaryLight,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          color: primaryLight,
          fontSize: 18,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        displaySmall: TextStyle(
          color: onSurfaceLight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        displayMedium: TextStyle(
          color: onSurfaceLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        displayLarge: TextStyle(
          color: onBackgroundLight,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        labelMedium: TextStyle(
          color: primaryLight,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        titleSmall: TextStyle(
          color: primaryLight,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleMedium: TextStyle(
          color: onBackgroundLight,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        titleLarge: TextStyle(
          color: primaryLight,
          fontWeight: FontWeight.w500,
          fontSize: 23,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isCollapsed: true,
        hintStyle: TextStyle(
          fontSize: 14,
          color: primaryContainerLight,
        ),
        border: InputBorder.none,
        isDense: true,
      ),
    );

const primaryDark = Color.fromARGB(255, 0, 131, 207);
const onPrimaryDark = Color(0xFFFFFFFF);
const primaryVariantDark = Color(0xFF00314E);
const secondaryDark = Color.fromARGB(255, 7, 124, 202);
const secondaryVariantDark = Color.fromARGB(255, 0, 41, 58);
const tertiaryDark = Color(0xff06283D);

const backgroundDark = Color.fromARGB(255, 32, 32, 32);
const onBackgroundDark = Color.fromARGB(255, 219, 219, 219);
const surfaceDark = Color.fromARGB(255, 48, 48, 48);
const onSurfaceDark = Color.fromARGB(255, 187, 187, 187);

const primaryContainerDark = Color(0xFF494949);
const onPrimaryContainerDark = Color(0xFF868686);
const onSurfaceVariantDark = Color(0xFF383838);
const secondaryContainerDark = Color(0xFFA3A3A3);

const shadowDark = Color(0x28FFFFFF);

ThemeData darkTheme() => ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
        primary: primaryDark,
        primaryVariant: primaryVariantDark,
        onPrimary: onPrimaryDark,
        secondary: secondaryDark,
        secondaryVariant: secondaryVariantDark,
        onSecondary: Colors.white,
        tertiary: tertiaryDark,
        brightness: Brightness.dark,
        error: Colors.red,
        onError: Colors.white,
        background: backgroundDark,
        onBackground: onBackgroundDark,
        surfaceVariant: const Color(0x00EEEEEE),
        outline: onBackgroundDark.withOpacity(.6),
        surface: surfaceDark,
        onSurface: onSurfaceDark,
        shadow: shadowDark,
        onSurfaceVariant: onSurfaceVariantDark,
        primaryContainer: primaryContainerDark,
        onPrimaryContainer: onPrimaryContainerDark,
        secondaryContainer: secondaryContainerDark,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: surfaceDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 47,
            ),
          ),
        ),
      ),
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff016EAF),
        centerTitle: true,
        // toolbarHeight: 57,
        shadowColor: Color(0x1E000000),
        elevation: 3,
      ),
      buttonTheme: const ButtonThemeData(),
      iconTheme: const IconThemeData(
        opacity: 1,
        color: Colors.white,
        size: 30.0,
      ),
      fontFamily: GoogleFonts.arimo().fontFamily,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: primaryDark,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          color: primaryDark,
          fontSize: 18,
        ),
        bodySmall: TextStyle(
          color: onBackgroundDark,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        displaySmall: TextStyle(
          color: onSurfaceDark,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        displayMedium: TextStyle(
          color: onSurfaceDark,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        displayLarge: TextStyle(
          color: onBackgroundDark,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        labelMedium: TextStyle(
          color: onSurfaceDark,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        titleSmall: TextStyle(
          color: primaryDark,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleMedium: TextStyle(
          color: onPrimaryDark,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        titleLarge: TextStyle(
          color: primaryDark,
          fontWeight: FontWeight.w500,
          fontSize: 24,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isCollapsed: true,
        hintStyle: TextStyle(
          fontSize: 14,
          color: primaryContainerDark,
        ),
        border: InputBorder.none,
        isDense: true,
      ),
    );
