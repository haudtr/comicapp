import 'package:comic_app/home_screen_anmie.dart';
import 'package:comic_app/login.dart';
import 'package:comic_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';



void main() => runApp(
  DevicePreview(
    enabled: true,
    builder: (context) => MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color:Colors.white,
          )),
      darkTheme: ThemeData.dark(),
      home: const HomeComic(),
    );
  }
}

