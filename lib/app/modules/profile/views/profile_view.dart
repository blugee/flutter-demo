import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/home/controllers/home_controller.dart';
import 'package:mocci/app/modules/profile/views/privacyPolicy.dart';
import 'package:mocci/app/modules/profile/views/terms&condition.dart';
import 'package:mocci/app/modules/walkthrough/views/splashScreen.dart';
import 'package:mocci/app/routes/app_pages.dart';
import '../controllers/profile_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends GetView<ProfileController> {
  final appStorage = GetStorage();
  final _c = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
        ),
      ),
      body: Obx(
        () => Scrollbar(
          thickness: 5,
          hoverThickness: 20,
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              SizedBox(height: kDynamicWidth.width10),
              controller.isLoggedIn.value
                  ? Column(
                      children: [
                        listTileForProfile('Account', 'assets/images/user.svg',
                            () => Get.toNamed(Routes.ACCOUNT)),
                        listTileForProfile(
                            'Settings',
                            'assets/images/setting.svg',
                            () => Get.toNamed(Routes.SETTINGS)),
                        listTileForProfile(
                            'Shipping Address',
                            'assets/images/shipping.svg',
                            () => Get.toNamed(Routes.SHIPPING_ADDRESS)),
                        listTileForProfile(
                            'My Orders',
                            'assets/images/orderHis.svg',
                            () => Get.toNamed(Routes.MY_ORDERS)),
                        listTileForProfile(
                            'Wishlist',
                            'assets/images/Mywishlist.svg',
                            () => HomeController.to.currentIndex.value = 1),
                        Container(
                          height: 8.h,
                          color: kColors.GREY_2,
                        )
                      ],
                    )
                  : Column(
                      children: [
                        listTileForProfile('Login', 'assets/images/user.svg',
                            () => Get.toNamed(Routes.LOGIN)),
                        listTileForProfile(
                            'Signup',
                            'assets/images/adduser.svg',
                            () => Get.toNamed(Routes.SIGNUP)),
                      ],
                    ),
              SizedBox(height: kDynamicWidth.width10),
              listTileForProfile(
                  'Send Feedback', 'assets/images/comment.svg', () {}),
              listTileForProfile('Terms of Use', 'assets/images/terms.svg', () {
                Get.to(() => TermsOfUse(), transition: Transition.rightToLeft);
              }),
              listTileForProfile('Privacy Policy', 'assets/images/privacy.svg',
                  () {
                Get.to(() => PrivacyPolicy(),
                    transition: Transition.rightToLeft);
              }),
              Visibility(
                visible: controller.isLoggedIn.value,
                child: listTileForProfile('Logout', 'assets/images/logout.svg',
                    () => defaultDialog(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> defaultDialog(BuildContext context) {
    return Get.defaultDialog(
        title: 'Logout',
        titleStyle: kTextStyle.f16w5.copyWith(color: kColors.DARK_BLUE),
        titlePadding: EdgeInsets.only(top: 10),
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        middleText: 'Are you sure ?',
        radius: 5,
        onConfirm: () async {
          await appStorage.erase();
          controller.checkLoginStatus();
          await showToast(context, 'Logged Out');
          Navigator.pop(context);
        },
        onCancel: () => Get.back(),
        barrierDismissible: false,
        textConfirm: 'Yes',
        confirmTextColor: Colors.white,
        textCancel: 'No');
  }
}
