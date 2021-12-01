import 'dart:async';
import 'dart:io';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocci/app/data/LocalStorage/localStorage.dart';
import 'package:mocci/app/data/Models/login_Model.dart';
import 'package:mocci/app/data/Provider/provider.dart';
import 'package:mocci/app/data/Repository/repository.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/home/controllers/home_controller.dart';
import 'package:mocci/app/modules/profile/controllers/profile_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mocci/app/data/Models/token_getter_model.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();

  TextEditingController loginEmail_Cont = TextEditingController();
  TextEditingController loginPass_Cont = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  final appStorage = GetStorage();
  final _repository = Repository();
  RxBool passwordVisibility = true.obs;

  Future<dynamic> loginSubmit(BuildContext context) async {
    if (loginFormKey.currentState.validate()) {
      await hideKeyboard(context);
      Get.showOverlay(
          asyncFunction: () => _doLogin(context),
          loadingWidget: mocciLoader(35));
    }
  }

  Future<void> _doLogin(context) async {
    try {
      await _repository
          .loginAPI(
              loginEmail: loginEmail_Cont.text.trim(),
              loginPass: loginPass_Cont.text)
          .then((LoginModel value) async {
        if (value.status) {
          await getAccessToken();
          //deleteAccessToken();
          /// for getting access token from shapeways and delete manually after 45 minutes.
          await appStorage.write('isLoggedIn', true);
          await appStorage.write('token', value.result.token);
          await showToast(context, 'You are now logged In');
          await ProfileController.to.checkLoginStatus();
          HomeController.to.currentIndex.value = 3;
          Get.offNamed(Routes.HOME);
        } else {
          errorSnackbar('${value.message}');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    loginPass_Cont.dispose();
    loginEmail_Cont.dispose();

    super.onClose();
  }

  getAccessToken() async => await _repository.getAccessToken();
}
