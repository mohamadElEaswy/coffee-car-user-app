import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mk/src/ui/colors/static_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Sora',
    scaffoldBackgroundColor: Colors.white,
    drawerTheme: const DrawerThemeData(
      // backgroundColor: Colors.white,
      elevation: 0.0,
    ),
    // fontFamily: GoogleFonts.getFont('sora'),
    // textTheme: GoogleFonts.sora(),
    primarySwatch: GlobalStaticColors.primaryColor,
    appBarTheme: AppBarTheme(
        color: Colors.grey[200],
        elevation: 0.0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black),
        // backgroundColor: Colors.grey[200],

        // actionsIconTheme: IconThemeData(
        //   color: Colors.black,
        // ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          // color: GlobalStaticColors.logoColor,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Sora',
    primarySwatch: Colors.blue,
  );

  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle boldTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  // static TextStyle dynamicTextStyle(
  //         double fontSize, Color? color, FontWeight? fontWeight) =>
  //     GoogleFonts.sora(
  //       color: color,
  //       fontSize: fontSize,
  //       fontWeight: fontWeight,
  //     );
}
