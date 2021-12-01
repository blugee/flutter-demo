import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/walkthrough/views/walkthrough_view.dart';
import 'package:mocci/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          color: kColors.DARK_BLUE,
        ),
        padding: EdgeInsets.all(kDynamicWidth.width20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                color: Colors.white,
              ),
            ),
            Spacer(),
            Text(
              'MOCCI',
              style: kTextStyle.f20w5
                  .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
            ),
            Text(
              ' Customize your Jewellery',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.w700,
                  fontSize: 30.sp),
            ),
            SizedBox(
              height: kDynamicWidth.width20,
            ),
            MainButton(
                title: "Get Started",
                onPress: () async {
                  await Get.to(() => WalkThrough(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 400));
                },
                buttonColor: kColors.ERROR_YELLOW),
            SizedBox(
              height: kDynamicWidth.width10,
            ),
            TextButton(
              onPressed: () async {
                await Get.offAndToNamed(Routes.HOME);
              },
              child: Text(
                'Skip',
                style: kTextStyle.f14w4.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
