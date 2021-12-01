import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/LocalStorage/localStorage.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/modules/walkthrough/views/intro_screen.dart';
import 'package:mocci/app/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;
  double _opacity = 0;
  bool _value = true;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            LocalStorage().IS_LOGIN() ?? false
                ? Get.offNamed(Routes.HOME)
                : Get.off(() => IntroScreen(),
                    transition: Transition.topLevel,
                    duration: const Duration(milliseconds: 500));
            Timer(
              const Duration(milliseconds: 300),
              () {
                _scaleController.reset();
              },
            );
          }
        },
      );

    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(_scaleController);

    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        _scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(seconds: 6),
              opacity: _opacity,
              child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(seconds: 2),
                height: _value ? 50 : 200,
                width: _value ? 50 : 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: kColors.ERROR_YELLOW,
                      // blurRadius: 100,
                      // spreadRadius: 10,
                    ),
                  ],
                  color: kColors.ERROR_YELLOW,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: kColors.ERROR_YELLOW, shape: BoxShape.circle),
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (c, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kColors.ERROR_YELLOW,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: SvgPicture.asset('assets/images/splash.svg'),
          )
        ],
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  ThisIsFadeRoute({this.page, this.route})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: route,
          ),
        );
}
