import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/utils/cardUtils.dart';

class CreditCardController extends GetxController {
  // TextEditingController cardName = TextEditingController();
  // TextEditingController cardNumber = TextEditingController();
  // TextEditingController monthYear = TextEditingController();
  RxString cardNumber = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cardHolderName = ''.obs;
  RxString cvvCode = ''.obs;
  RxBool isCvvFocused = false.obs;
  GlobalKey<ScaffoldState> cardScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();

  // TextEditingController cvv = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // cardName.dispose();
    // cardNumber.dispose();
    // cvv.dispose();
    // monthYear.dispose();
    super.onClose();
  }
}
