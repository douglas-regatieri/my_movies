import 'package:flutter/material.dart';
import 'package:my_movies/shared/themes/app_colors.dart';
import 'package:my_movies/shared/themes/app_images.dart';
import 'package:my_movies/shared/themes/app_text_styles.dart';
import 'package:my_movies/shared/widgets/social_login/social_login_button.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.20,
              color: AppColors.primary,
            ),
            Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppImages.popcorn,
                  width: 208,
                  height: 373,
                )),
            Positioned(
              bottom: size.height * 0.20,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 70, right: 70, top: 20),
                    child: Text(
                      "My movies",
                      textAlign: TextAlign.center,
                      style: TextStyles.titleHome,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 70, right: 70, top: 20),
                    child: Text(
                      "Seu catalogo de filmes",
                      textAlign: TextAlign.center,
                      style: TextStyles.titleBoldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: 100,
                    ),
                    child: SocialLoginButton(
                      onTap: () {
                        controller.googleSignIn(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
