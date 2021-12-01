import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/mixins/validation_mixins.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/login/controllers/login_controller.dart';
import 'package:mocci/app/modules/login/views/login_view.dart';
import 'package:mocci/app/routes/app_pages.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> with ValidationMixin {
  final _l = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.signUpFormKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: controller.signUpScaffoldKey,
        appBar: AppBar(
          title: appBarTitle('Sign up'),
        ),
        body: ListView(
          padding: EdgeInsets.all(
            kDynamicWidth.width20,
          ),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            buildInputField(
                title: "First name",
                textController: controller.signup_firstName,
                isIcon: false,
                validator: validateReqFields),
            buildInputField(
                title: "Last name",
                textController: controller.signup_lastName,
                isIcon: false,
                validator: validateReqFields),
            buildInputField(
                title: "Email",
                textController: controller.signup_email,
                isIcon: false,
                validator: validateEmail),
            buildInputField(
                title: "Password",
                textController: controller.signup_pass,
                isIcon: false,
                validator: validateReqFields),
            Obx(
              () => buildInputField(
                title: "Confirm Password",
                textController: controller.signup_ConfirmPass,
                isIcon: true,
                validator: controller.validateSignUpPasswords,
              ),
            ),
            SizedBox(
              height: kDynamicWidth.width20,
            ),
            MainButton(
                title: 'Submit',
                onPress: () => controller.onSignupSubmit(context),
                buttonColor: kColors.ERROR_YELLOW),
            SizedBox(
              height: kDynamicWidth.width20,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have a account?',
                      style: kTextStyle.f16w5.copyWith(
                          color: kColors.DARK_GREY,
                          fontFamily: 'Carmen Sans',
                          decoration: TextDecoration.none,
                          fontSize: 15),
                    ),
                    TextSpan(
                      text: 'Log in',
                      style: kTextStyle.f16w5.copyWith(
                          color: kColors.DARK_BLUE,
                          fontFamily: 'Carmen Sans',
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(Routes.LOGIN);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
