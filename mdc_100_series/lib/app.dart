import 'package:flutter/material.dart';
import 'package:shrine/backdrop.dart';
import 'package:shrine/category_menu_page.dart';
import 'package:shrine/colors.dart';
import 'package:shrine/model/product.dart';
import 'package:shrine/supplemental/cut_corners_border.dart';

import 'home.dart';
import 'login.dart';

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kShrinePurple,
      // onPrimary: kShrineBrown900,
      secondary: kShrinePurple,
      error: kShrineErrorRed
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    scaffoldBackgroundColor: kShrinePurpleLight,
    textSelectionTheme: const TextSelectionThemeData(selectionColor: kShrinePink100),
    inputDecorationTheme: const InputDecorationTheme(
      border: CutCornersBorder(),
      focusedBorder: CutCornersBorder(
        borderSide: BorderSide(
          width: 2,
          color: kShrineBrown900
        )
      ),
      floatingLabelStyle: TextStyle(
        color: kShrineBrown900
      )
    )
  );
}


TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.copyWith(
    headline5: base.headline5!.copyWith(
      fontWeight: FontWeight.w500
    )
  ) .apply(
      fontFamily: 'Rubik',
      bodyColor: kShrinePurple,
      displayColor: kShrinePurple
    );
}

final ThemeData kShrineTheme = _buildShrineTheme();

// TODO: Convert ShrineApp to stateful widget (104)
class ShrineApp extends StatefulWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  State<ShrineApp> createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  Category _currentCategory = Category.all;
  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      initialRoute: '/',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => Backdrop(
          currentCategory: Category.all,
          frontLayer: HomePage(currentCategory: _currentCategory), 
          backLayer: CategoryMenuPage(currentCategory: _currentCategory, onCategoryTap: _onCategoryTap), 
          frontTitle: const Text("SHRINE"), 
          backTitle: const Text("MENU"))
      },
      theme: kShrineTheme
    );
  }
}

// TODO: Build a Shrine Theme (103)
// TODO: Build a Shrine Text Theme (103)
