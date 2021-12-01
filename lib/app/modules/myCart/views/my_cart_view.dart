import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mocci/app/data/LocalStorage/localStorage.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/home/controllers/home_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';

import '../controllers/my_cart_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCartView extends GetView<MyCartController> {
  final _storage = LocalStorage();
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
          'Cart',
          style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20.h),
          Visibility(
            visible: false,
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: kColors.DARK_BLUE,
                    size: 100,
                  ),
                  SizedBox(
                    height: kDynamicWidth.width20,
                  ),
                  Center(
                    child: Text(
                      'Your Shopping cart is empty.',
                      style:
                          kTextStyle.f16w5.copyWith(color: kColors.DARK_GREY),
                    ),
                  ),
                  SizedBox(
                    height: kDynamicWidth.width20,
                  ),
                  MainButton(
                      title: 'Shop Now',
                      onPress: () {
                        HomeController.to.currentIndex.value = 0;
                      },
                      buttonColor: kColors.ERROR_YELLOW),
                ],
              ),
            ),
          ),
          CartItemWidget(),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.17,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0.7, 0),
            child: Container(
              width: Get.width * 0.7,
              height: Get.height * 0.15,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 20, color: Color(0x2D0D0202))
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-0.5, 0),
                    child: Text(
                      'Pendants',
                      style: kTextStyle.f18w6.copyWith(
                          fontSize: 13.sp, color: kColors.ERROR_YELLOW),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.6, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'The Italia Pendant',
                          style: kTextStyle.f16w5
                              .copyWith(color: kColors.DARK_BLUE),
                        ),
                        SizedBox(width: 5.w),
                        Icon(
                          Icons.clear,
                          color: kColors.DARK_GREY,
                          size: 15,
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          width: Get.width * 0.09,
                          height: Get.height * 0.04,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            border: Border.all(
                              width: 0.5,
                              color: Color(0xFF0D0202),
                            ),
                          ),
                          child: Center(
                            child: Text('1',
                                style: kTextStyle.f16w5
                                    .copyWith(color: kColors.DARK_BLUE)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.5, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.CREDIT_CARD),
                          child: Container(
                            width: Get.width * 0.22,
                            height: Get.height * 0.04,
                            decoration: BoxDecoration(
                              color: Color(0xFF273751),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'Checkout',
                                style: kTextStyle.f13w5
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 4.9,
                        ),
                        Text(
                          '\$22',
                          style: kTextStyle.f18w6.copyWith(
                              fontWeight: FontWeight.w800,
                              color: kColors.ERROR_YELLOW),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.89, 0),
            child: Container(
              width: Get.width * 0.28,
              height: Get.height * 0.12,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Color(0x37110303),
                  )
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: customCacheNetwokImage(
                      'https://picsum.photos/seed/834/600', 3),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
