import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/settings/views/aboutApp.dart';
import 'package:mocci/app/modules/settings/views/notification_view.dart';
import 'package:mocci/app/modules/settings/views/password_view.dart';
import 'package:mocci/app/routes/app_pages.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: kDynamicWidth.width10,
            ),
            listTileForProfile('Change Password', 'assets/images/password.svg',
                () => Get.to(() => UpdatePasswordView())),
            listTileForProfile(
              'Payment Methods',
              'assets/images/security.svg',
              () => Get.toNamed(Routes.CREDIT_CARD),
            ),
            listTileForProfile(
              'Security',
              'assets/images/security.svg',
              () => null,
            ),
            listTileForProfile('Notifications', 'assets/images/noti.svg',
                () => Get.to(() => NotificationView())),
            listTileForProfile(
              'About App',
              'assets/images/about.svg',
              () => Get.to(() => AboutApp()),
            ),
            listTileForProfile(
              'Help Center',
              'assets/images/help.svg',
              () => null,
            )
          ],
        ));
  }
}
