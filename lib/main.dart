<<<<<<< HEAD
import 'package:comic_app/detail_comic.dart';
import 'package:comic_app/home_screen_anmie.dart';
import 'package:comic_app/login.dart';
import 'package:comic_app/login_screen/login_screen.dart';
import 'package:comic_app/provider/chapterProvider.dart';
import 'package:comic_app/provider/comicProvider.dart';
import 'package:comic_app/provider/commentProvider.dart';
import 'package:comic_app/provider/favoriteProvider.dart';
import 'package:comic_app/provider/ratingProvider.dart';
import 'package:comic_app/provider/user.dart';
import 'package:comic_app/reading_page.dart';
import 'package:comic_app/signup.dart';

import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ComicProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => RatingProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ChangeNotifierProvider(create: (_) => ChapterProvider()),
          ChangeNotifierProvider(create: (_) => CommentProvider()),
        ],
        child: DevicePreview(
          enabled: false,
          builder: (context) => const MyApp(), // Wrap your app
        ),
      ),
    );
=======
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:comic_app/page/edit_profile.dart';
import 'package:comic_app/page/profile_page.dart';
import 'package:comic_app/themes.dart';
import 'package:comic_app/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}
>>>>>>> d7b631573512657c8503e2f25772d3adf0841871

class MyApp extends StatelessWidget {
  static final String title = 'User Profile';

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        color: Colors.white,
      )),
      // darkTheme: ThemeData.dark(),
      home: const LoginScreen(),
=======
    final user = UserPreferences.myUser;

    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          home: ProfilePage(),
        ),
      ),
>>>>>>> d7b631573512657c8503e2f25772d3adf0841871
    );
  }
}