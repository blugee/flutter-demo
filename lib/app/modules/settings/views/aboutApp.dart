import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/modules/settings/controllers/settings_controller.dart';
import 'package:package_info/package_info.dart';

class AboutApp extends GetView<SettingsController> {
  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: kTextStyle.f16w5.copyWith(color: kColors.DARK_BLUE),
      ),
      subtitle: Text(subtitle ?? 'Not set'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About App',
          style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
        ),
      ),
      body: Obx(() {
        return ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            _infoTile('App name', controller.appName.value),
            _infoTile('Package name', controller.packageName.value),
            _infoTile('App version', controller.ver.value),
            _infoTile('Build number', controller.buildNum.value),
          ],
        );
      }),
    );
  }
}
