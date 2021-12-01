import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/login/controllers/login_controller.dart';
import 'package:mocci/app/modules/settings/controllers/settings_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';

class UpdatePasswordView extends GetView<SettingsController> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              'Password',
              style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(kDynamicWidth.width20),
            children: [
              buildInputField(
                  title: "Current Password",
                  textController: controller.currentPass,
                  isIcon: false,
                  validator: controller.validatePassword),
              buildInputField(
                  title: "New Password",
                  textController: controller.newPass,
                  isIcon: false,
                  validator: controller.newPassValidator),
              buildInputField(
                  title: "Confirm Password",
                  textController: controller.confirmPass,
                  isIcon: false,
                  validator: controller.confirmPassValidator),
              SizedBox(
                height: kDynamicWidth.width20,
              ),
              MainButton(
                title: 'Update Password',
                buttonColor: kColors.ERROR_YELLOW,
                onPress: () async {
                  if (_formKey.currentState.validate()) {
                    await showToast(context, 'Password Successfully Updated');
                    Timer(Duration(seconds: 1),
                        () => Get.offNamed(Routes.SETTINGS));
                  }
                },
              )
            ],
          )),
    );
  }
}
