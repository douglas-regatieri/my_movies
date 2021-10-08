import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'modules/favorites/favorites_page.dart';
import 'modules/filme_details/filme_details.dart';
import 'modules/home/home_page.dart';
import 'modules/login/login_page.dart';
import 'modules/splash/splash_page.dart';
import 'shared/models/user_model.dart';
import 'shared/themes/app_colors.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.primary));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Movies',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Colors.red, primaryColor: AppColors.primary),
      initialRoute: "/login",
      routes: {
        "/splash": (context) => SplashPage(),
        "/home": (context) => HomePage(
              user: ModalRoute.of(context)!.settings.arguments as UserModel,
            ),
        "/login": (context) => LoginPage(),
      },
    );
  }
}
