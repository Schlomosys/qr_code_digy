import 'dart:core';

import 'package:canvanime/qr_code_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canvanime/provider/DarkThemeProvider.dart';
import 'package:canvanime/Styles/DarkThemeStyles.dart';






void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.appPreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(
        create: (_) {
          return themeChangeProvider;
        },
        child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              //home:QrCodeGen(),
              home:QrCodeGen(),
             // routes: <String, WidgetBuilder>{
                //AGENDA: (BuildContext context) => AgendaScreen(),
              //},
            );
          },
        ),);
  }
}