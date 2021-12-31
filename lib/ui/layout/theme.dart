import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_roomie/core/models/theme_model.dart';

class ThemeNotifier extends ChangeNotifier {
  late List<ThemeModel> _themes;

  Random _random = Random();
  late int _currentTheme;

  ThemeNotifier() {
    _themes = [
      ThemeModel(1, Color(0xFFFEBD00), Color(0xFFFCF4DC), theme1()),
      ThemeModel(2, Color(0xFF8CD2E8), Color(0xFFEEFBFF), theme2()),
      ThemeModel(3, Color(0xFF58A281), Color(0xFFEEFFF7), theme3()),
      ThemeModel(4, Color(0xFFF58FA4), Color(0xFFFFEEF2), theme4()),
      ThemeModel(5, Color(0xFF6F62E2), Color(0xFFE6E3FF), theme5()),
    ];
    _currentTheme = _random.nextInt(5);
  }

  ThemeModel get currentTheme => _themes[_currentTheme];

  void setCurrentTheme(int x) {
    x = x % 5;
    _currentTheme = x;
    notifyListeners();
  }

  void changeTheme() {
    _currentTheme = (_currentTheme + 1) % 5;
    notifyListeners();
  }

  ThemeData theme1() => ThemeData(
      primarySwatch: Colors.blue,
      inputDecorationTheme: const InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Color(0xffFCF4DC),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xffFEBD00)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xffFEBD00)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xffFEBD00)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          )),
      textTheme: TextTheme(
          headline1: GoogleFonts.reenieBeanie(
              textStyle: TextStyle(fontSize: 82, color: Colors.black)),
          bodyText1: GoogleFonts.reemKufi(color: Colors.black)));

  ThemeData theme2() => ThemeData(
      primarySwatch: Colors.blue,
      inputDecorationTheme: const InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Color(0xFFEEFBFF),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xFF8CD2E8)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xFF8CD2E8)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xFF8CD2E8)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          )),
      textTheme: TextTheme(
          headline1: GoogleFonts.reenieBeanie(
              textStyle: TextStyle(fontSize: 82, color: Colors.black)),
          bodyText1: GoogleFonts.reemKufi(color: Colors.black)));

  ThemeData theme3() => ThemeData(
      primarySwatch: Colors.blue,
      inputDecorationTheme: const InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Color(0xFFEEFFF7),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xFF58A281)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xFF58A281)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xFF58A281)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          )),
      textTheme: TextTheme(
          headline1: GoogleFonts.reenieBeanie(
              textStyle: TextStyle(fontSize: 82, color: Colors.black)),
          bodyText1: GoogleFonts.reemKufi(color: Colors.black)));

  ThemeData theme4() => ThemeData(
      primarySwatch: Colors.blue,
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Color(0xFFFFEEF2),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Color(0xFFF58FA4)),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Color(0xFFF58FA4)),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Color(0xFFF58FA4)),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
      textTheme: TextTheme(
          headline1: GoogleFonts.reenieBeanie(
              textStyle: TextStyle(fontSize: 82, color: Colors.black)),
          bodyText1: GoogleFonts.reemKufi(color: Colors.black)));

  ThemeData theme5() => ThemeData(
      primarySwatch: Colors.blue,
      inputDecorationTheme: const InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Color(0xFFE6E3FF),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xFF6F62E2)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xFF6F62E2)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color(0xFF6F62E2)),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          )),
      textTheme: TextTheme(
          headline1: GoogleFonts.reenieBeanie(
              textStyle: TextStyle(fontSize: 82, color: Colors.black)),
          bodyText1: GoogleFonts.reemKufi(color: Colors.black)));
}
