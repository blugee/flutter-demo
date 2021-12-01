import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocci/app/data/LocalStorage/localStorage.dart';
import 'package:mocci/app/data/constants.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
      .copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(Get.width, Get.height),
        builder: () => GetMaterialApp(
              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget,
                );
              },
              theme: customTheme,
              title: "Mocci",
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              popGesture: Platform.isIOS ? true : false,
            ));
  }
}

ThemeData customTheme = ThemeData(
  fontFamily: 'Carmen Sans',
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    centerTitle: true,
    titleTextStyle: kTextStyle.f18w6.copyWith(
      color: kColors.DARK_BLUE,
      fontFamily: 'Carmen Sans',
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: kColors.DARK_BLUE),
  ),
  sliderTheme: SliderThemeData(
      inactiveTrackColor: kColors.DARK_GREY,
      activeTrackColor: kColors.ERROR_YELLOW,
      thumbColor: kColors.ERROR_YELLOW),
  inputDecorationTheme: InputDecorationTheme(
    focusColor: kColors.ERROR_YELLOW,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: kColors.DARK_GREY,
        width: 1,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: kColors.ERROR_YELLOW,
        width: 1,
      ),
    ),
  ),
  indicatorColor: kColors.ERROR_YELLOW,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedIconTheme: IconThemeData(color: kColors.DARK_GREY),
      selectedIconTheme: IconThemeData(color: kColors.ERROR_YELLOW),
      selectedItemColor: kColors.ERROR_YELLOW,
      unselectedItemColor: kColors.DARK_GREY),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: kColors.ERROR_YELLOW),
);
