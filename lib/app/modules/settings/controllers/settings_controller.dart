import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class SettingsController extends GetxController {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  RxString appName = ''.obs;
  RxString packageName = ''.obs;
  RxString ver = ''.obs;
  RxString buildNum = ''.obs;

  appInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    ver.value = packageInfo.version;
    appName.value = packageInfo.appName;
    buildNum.value = packageInfo.buildNumber;
    packageName.value = packageInfo.packageName;
  }

  String validatePassword(value) {
    if (GetUtils.isNullOrBlank(value)) {
      return '*Required Field';
    } else {
      return null;
    }
  }

  String newPassValidator(value) {
    if (value.length == 0) {
      return '*Required Field';
    } else if (GetUtils.isLengthLessThan(value, 8)) {
      return 'Password must be 8 digits';
    } else {
      return null;
    }
  }

  String confirmPassValidator(value) {
    if (value.length == 0) {
      return '*Required Field';
    } else if (value != newPass.text) {
      return 'Password Don\'t match';
    } else {
      return null;
    }
  }

  @override
  void onClose() {
    confirmPass.dispose();
    newPass.dispose();
    currentPass.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    appInfo();
  }
}
