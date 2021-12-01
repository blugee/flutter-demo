import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShippingAddressController extends GetxController {
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final address1 = TextEditingController();
  final address2 = TextEditingController();
  final phoneNo = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
