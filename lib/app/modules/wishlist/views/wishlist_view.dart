import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/LocalStorage/localStorage.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/home/controllers/home_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';

import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  final localStorage = LocalStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(9.0),
          child: SvgPicture.asset(
            'assets/images/splash.svg',
            color: kColors.ERROR_YELLOW,
          ),
        ),
        title: Text(
          'Wishlist',
          style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(kDynamicWidth.width16),
        shrinkWrap: true,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            color: kColors.PINKIESH,
            size: 100,
          ),
          SizedBox(
            height: kDynamicWidth.width20,
          ),
          Center(
            child: Text(
              'Your wishlist is empty.',
              style: kTextStyle.f16w5.copyWith(color: kColors.DARK_GREY),
            ),
          ),
          SizedBox(
            height: kDynamicWidth.width20,
          ),
          Row(
            children: [
              Visibility(
                  visible: localStorage.IS_LOGIN() == null ? true : false,
                  child: Expanded(child: _buildOutlinedButton())),
              Visibility(
                  visible: localStorage.IS_LOGIN() == null ? true : false,
                  child: SizedBox(width: 8.w)),
              Expanded(child: _buildMainButton())
            ],
          ),
        ],
      ),
    );
  }

  MainButton _buildMainButton() {
    return MainButton(
        title: 'Shop Now',
        onPress: () {
          HomeController.to.currentIndex.value = 0;
        },
        buttonColor: kColors.ERROR_YELLOW);
  }

  ConstrainedBox _buildOutlinedButton() {
    return ConstrainedBox(
        constraints:
            BoxConstraints.tightFor(width: Get.width, height: Get.width / 7),
        child: OutlinedButton(
            onPressed: () => Get.toNamed(Routes.LOGIN),
            child: Text(
              'Login',
              style: TextStyle(
                  color: kColors.ERROR_YELLOW,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp),
            )));
  }
}
