import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocci/app/data/Models/signUp_Model.dart';
import 'package:mocci/app/data/Repository/repository.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/home/controllers/home_controller.dart';
import 'package:mocci/app/modules/profile/controllers/profile_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';

class SignupController extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> signUpScaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController signup_email = TextEditingController();
  TextEditingController signup_pass = TextEditingController();
  TextEditingController signup_ConfirmPass = TextEditingController();
  TextEditingController signup_firstName = TextEditingController();
  TextEditingController signup_lastName = TextEditingController();
  final appStorage = GetStorage();
  final _repository = Repository();

  Future<dynamic> onSignupSubmit(BuildContext context) async {
    if (signUpFormKey.currentState.validate()) {
      await hideKeyboard(context);
      Get.showOverlay(
          asyncFunction: () => _SignUpApi(context),
          loadingWidget: mocciLoader(35));
    }
  }

  Future<void> _SignUpApi(BuildContext context) async {
    try {
      await _repository
          .signUpAPI(
              firstName: signup_firstName.text.trim(),
              lastName: signup_lastName.text.trim(),
              email: signup_email.text,
              pass: signup_pass.text)
          .then((SignUpModel value) async {
        if (value.status) {
          await _repository.getAccessToken();

          /// ACCESS TOKEN FROM SHAPEWAY
          await showToast(context, 'Successfully Registered');
          await appStorage.write('isLoggedIn', true);
          await appStorage.write('token', value.result.token);
          await appStorage.write('name', signup_firstName.text);
          await appStorage.write('lastName', signup_lastName.text);
          await appStorage.write('email', signup_email.text);

          await ProfileController.to.checkLoginStatus();
          HomeController.to.currentIndex.value = 3;
          Get.offNamed(Routes.HOME);
        } else {
          errorSnackbar('${value.message}');
        }
      });
    } on SocketException catch (_) {
      print('You are not connected to internet');
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    super.onClose();
    signup_ConfirmPass.dispose();
    signup_pass.dispose();
    signup_lastName.dispose();
    signup_email.dispose();
    signup_firstName.dispose();
  }

  String validateSignUpPasswords(value) {
    if (GetUtils.isNullOrBlank(value)) {
      return '*Required Field';
    } else if (value != signup_pass.text) {
      return 'Passwords don\'t match';
    } else {
      return null;
    }
  }
}
