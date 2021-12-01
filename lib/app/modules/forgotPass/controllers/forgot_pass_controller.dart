import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/forgotPass/views/verifyOtpFromEmail.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPassController extends GetxController {
  final forgotPass = TextEditingController();
  final verifyOtpFromEmail = TextEditingController();
  final forgotPassFormKey = GlobalKey<FormState>();
  final forgotPassScaffoldKey = GlobalKey<ScaffoldState>();
  StreamController<ErrorAnimationType> errorController;
  RxBool isCompleted = false.obs;
  RxString currentText = "".obs;

  Future<dynamic> forgotPassOnSubmit(BuildContext context) async {
    if (forgotPassFormKey.currentState.validate()) {
      showToast(context, 'Email sent Successfully');

      Future.delayed(Duration(seconds: 2),
          () => Get.to(() => VerifyOtpFromEmail(), arguments: forgotPass.text));
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    forgotPass.dispose();
    verifyOtpFromEmail.dispose();
    super.dispose();
  }
}
