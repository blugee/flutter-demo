import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/forgotPass/controllers/forgot_pass_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpFromEmail extends GetView<ForgotPassController> {
  final String _forgotPassEmail = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle('Verify Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(kDynamicWidth.width20),
        child: Obx(
          () => Column(
            children: [
              Text(
                'Enter the code\nto Verify Your Email',
                textAlign: TextAlign.center,
                style: kTextStyle.f16w5.copyWith(
                    color: kColors.DARK_BLUE, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: kDynamicWidth.width10,
              ),
              Text.rich(
                TextSpan(
                    text: 'We have sent you an email with code to the ',
                    style: kTextStyle.f13w5
                        .copyWith(color: kColors.DARK_GREY, fontSize: 14),
                    children: [
                      TextSpan(
                          text: '$_forgotPassEmail',
                          style: kTextStyle.f13w5
                              .copyWith(color: kColors.DARK_BLUE, fontSize: 14))
                    ]),
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                maxLines: 2,
              ),
              SizedBox(height: kDynamicWidth.width20),
              _buildPinCodeTextField(context),
              SizedBox(height: kDynamicWidth.width20),
              MainButton(
                  title: 'Submit',
                  onPress: controller.currentText.value.length == 6
                      ? () => Get.offAllNamed(Routes.LOGIN)
                      : null,
                  buttonColor: kColors.ERROR_YELLOW),
            ],
          ),
        ),
      ),
    );
  }

  PinCodeTextField _buildPinCodeTextField(BuildContext context) {
    return PinCodeTextField(
        appContext: context,
        autoFocus: true,
        errorTextSpace: 30,
        pastedTextStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        animationType: AnimationType.scale,
        showCursor: false,
        autoDismissKeyboard: true,
        validator: (v) {
          if (GetUtils.isNullOrBlank(v)) {
            return "Please Provide OTP code";
          } else {
            return null;
          }
        },
        boxShadows: [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
        enablePinAutofill: true,
        autovalidateMode: AutovalidateMode.always,
        pinTheme: PinTheme(
          inactiveFillColor: Colors.grey.shade100,
          selectedColor: Colors.transparent,
          inactiveColor: Colors.grey.shade300,
          borderWidth: 1,
          activeColor: Colors.white,
          activeFillColor: Colors.white,
          selectedFillColor: kColors.ERROR_YELLOW,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
        ),
        cursorColor: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        errorAnimationController: controller.errorController,
        controller: controller.verifyOtpFromEmail,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          controller.currentText.value = value;
        },
        beforeTextPaste: (text) => true);
  }
}
