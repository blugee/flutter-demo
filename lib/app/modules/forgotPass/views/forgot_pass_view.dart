import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/mixins/validation_mixins.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/forgotPass/controllers/forgot_pass_controller.dart';

class ForgotPassView extends GetView<ForgotPassController>
    with ValidationMixin {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.forgotPassFormKey,
      autovalidateMode: AutovalidateMode.always,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: controller.forgotPassScaffoldKey,
          appBar: AppBar(
            title: appBarTitle(
              'Forgot Password',
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(kDynamicWidth.width20),
            child: Column(
              children: [
                Center(
                    child: Text(
                  """If you need help resetting your\npassword. We can help by sending\nyou a link to reset it.""",
                  textAlign: TextAlign.center,
                  style: kTextStyle.f16w5.copyWith(color: kColors.DARK_GREY),
                )),
                SizedBox(height: kDynamicWidth.width20),
                buildInputField(
                    title: "Email",
                    textController: controller.forgotPass,
                    isIcon: false,
                    validator: validateEmail),
                SizedBox(height: kDynamicWidth.width20),
                MainButton(
                    title: 'Submit',
                    onPress: () => controller.forgotPassOnSubmit(context),
                    buttonColor: kColors.ERROR_YELLOW),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
