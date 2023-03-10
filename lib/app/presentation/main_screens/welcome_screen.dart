import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/constants/colors/app_colors.dart';
import 'package:shop_app/app/constants/decoration/app_decoration.dart';
import 'package:shop_app/app/constants/text_styles/app_text_styles.dart';
import 'package:shop_app/app/presentation/widgets/animation_widgets/animated_logo_widget.dart';
import 'package:shop_app/app/presentation/widgets/buttons/yellow_button_widget.dart';

const textColors = [
  AppColors.yellowAccent,
  AppColors.red,
  AppColors.blueAccent,
  AppColors.green,
  AppColors.purple,
  AppColors.teal,
];

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppDecoration.welcomDecoration,
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    "Welcome",
                    textStyle: AppTextStyles.white45AcmeBold,
                    colors: textColors,
                  ),
                  ColorizeAnimatedText(
                    "Duck Store",
                    textStyle: AppTextStyles.white45AcmeBold,
                    colors: textColors,
                  ),
                ],
              ),
              const SizedBox(
                height: 120,
                width: 200,
                child: Image(
                  image: AssetImage('images/inapp/logo.jpg'),
                ),
              ),
              DefaultTextStyle(
                style: AppTextStyles.lightBlueAccent45BoldAcme,
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    RotateAnimatedText('Buy'),
                    RotateAnimatedText('Shop'),
                    RotateAnimatedText('Duck Store'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: AppDecoration.containerTextDecorationLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Suppliers only',
                            style: AppTextStyles.yellow26w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: AppDecoration.containerTextDecorationLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AnimatodLogoWidget(controller: _controller),
                            YellowButtonWidget(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/supplier_home_screen',
                                );
                              },
                              label: 'Log In',
                              width: 0.25,
                            ),
                            YellowButtonWidget(
                              onTap: () {},
                              label: 'Sign Up',
                              width: 0.25,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: AppDecoration.containerTextDecorationRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        YellowButtonWidget(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/customer_screen',
                            );
                          },
                          label: 'Log In',
                          width: 0.25,
                        ),
                        YellowButtonWidget(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/customer_register',
                            );
                          },
                          label: 'Sign Up',
                          width: 0.25,
                        ),
                        AnimatodLogoWidget(controller: _controller),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                color: AppColors.white38,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GoogleFacebooLoginWidget(
                      onPressed: () {},
                      label: 'Google',
                      child: const Image(
                        image: AssetImage('images/inapp/google.jpg'),
                      ),
                    ),
                    GoogleFacebooLoginWidget(
                      onPressed: () {},
                      label: 'Facebook',
                      child: const Image(
                        image: AssetImage('images/inapp/facebook.jpg'),
                      ),
                    ),
                    GoogleFacebooLoginWidget(
                      onPressed: () async {
                        try {
                          final userCredential =
                              await FirebaseAuth.instance.signInAnonymously();
                          print("Signed in with temporary account.");
                        } on FirebaseAuthException catch (e) {
                          switch (e.code) {
                            case "operation-not-allowed":
                              print(
                                  "Anonymous auth hasn't been enabled for this project.");
                              break;
                            default:
                              print("Unknown error.");
                          }
                        }
                        Navigator.pushReplacementNamed(
                          context,
                          '/customer_screen',
                        );
                      },
                      label: 'Guest',
                      child: const Icon(
                        Icons.person,
                        size: 55,
                        color: AppColors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleFacebooLoginWidget extends StatelessWidget {
  const GoogleFacebooLoginWidget({
    super.key,
    required this.child,
    required this.label,
    required this.onPressed,
  });
  final Widget child;
  final String label;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: child,
          ),
          Text(
            label,
            style: AppTextStyles.white,
          ),
        ],
      ),
    );
  }
}
