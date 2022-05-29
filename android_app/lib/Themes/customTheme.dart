// import 'package:flutter/material.dart';

// class CustomTheme with ChangeNotifier {
//   static bool _isDarkTheme = true;
//   ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

//   void toggleTheme() {
//     _isDarkTheme = !_isDarkTheme;
//     notifyListeners();
//   }

//   static ThemeData get lightTheme {
//     //1
//     return ThemeData(
//         //2
//         primaryColor: Colors.white,
//         scaffoldBackgroundColor: Colors.white,
//         fontFamily: 'Montserrat', //3
//         buttonTheme: ButtonThemeData(
//           // 4
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
//           buttonColor: CustomColors.lightPurple,
//         ));
//   }

//   static ThemeData get darkTheme {
//     return ThemeData(
//         primaryColor: CustomColors.darkGrey,
//         scaffoldBackgroundColor: Colors.black,
//         fontFamily: 'Montserrat',
//         textTheme: ThemeData.dark().textTheme,
//         buttonTheme: ButtonThemeData(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
//           buttonColor: CustomColors.lightPurple,
//         ));
//   }
// }
