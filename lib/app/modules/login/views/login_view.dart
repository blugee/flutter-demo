import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/mixins/validation_mixins.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';

import 'package:mocci/app/modules/profile/controllers/profile_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> with ValidationMixin {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: controller.loginScaffoldKey,
          appBar: AppBar(
            title: appBarTitle('Login'),
          ),
          body: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.all(
              kDynamicWidth.width20,
            ),
            children: [
              buildInputField(
                title: "Email",
                textController: controller.loginEmail_Cont,
                isIcon: false,
                validator: validateEmail,
              ),
              Obx(
                () => buildInputField(
                    title: "Password",
                    textController: controller.loginPass_Cont,
                    isIcon: true,
                    validator: validateReqFields),
              ),
              SizedBox(
                height: kDynamicWidth.width20,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.FORGOT_PASS);
                },
                child: Text(
                  'Forgot Password?',
                  style: kTextStyle.f16w5.copyWith(
                    color: kColors.DARK_GREY,
                  ),
                ),
              ),
              SizedBox(
                height: kDynamicWidth.width20,
              ),
              MainButton(
                  title: 'Login',
                  onPress: () {
                    controller.loginSubmit(context);
                  },
                  buttonColor: kColors.ERROR_YELLOW),
              SizedBox(
                height: kDynamicWidth.width20,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Sign up ',
                        style: kTextStyle.f16w5.copyWith(
                            color: kColors.DARK_BLUE,
                            fontFamily: 'Carmen Sans',
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.SIGNUP);
                          },
                      ),
                      TextSpan(
                        text: ' for free account',
                        style: kTextStyle.f16w5.copyWith(
                            color: kColors.DARK_GREY,
                            fontFamily: 'Carmen Sans',
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 5,
              ),
              _buildSignInButtons(
                  'Sign up with phone',
                  Colors.white,
                  true,
                  Icon(
                    Icons.phone_android_rounded,
                    color: kColors.DARK_GREY,
                  ),
                  kColors.DARK_BLUE,
                  false),
              SizedBox(
                height: kDynamicWidth.width10,
              ),
              _buildSignInButtons(
                  'Continue with Facebook',
                  Color(0xff3B5999),
                  false,
                  Icon(
                    Icons.facebook_rounded,
                    color: Colors.white,
                  ),
                  Colors.white,
                  false),
              SizedBox(
                height: kDynamicWidth.width10,
              ),
              _buildSignInButtons(
                  'Continue with Gmail',
                  Color(0xff4286F5),
                  false,
                  Icon(
                    Icons.facebook,
                    color: Colors.white,
                  ),
                  Colors.white,
                  true)
            ],
          ),
        ),
      ),
    );
  }

  Container _buildSignInButtons(String title, Color buttonColor, bool isOutline,
      Icon icon, Color textColor, bool isGmail) {
    return Container(
      height: Get.width / 7,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: kDynamicWidth.width20),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: isOutline ? kColors.DARK_GREY : Colors.transparent,
              width: 0.6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isGmail ? SvgPicture.asset('assets/images/gmailIcon.svg') : icon,
          SizedBox(
            width: kDynamicWidth.width20,
          ),
          Text(
            title,
            style: kTextStyle.f16w5.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
