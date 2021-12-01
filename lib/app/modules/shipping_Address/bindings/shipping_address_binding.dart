import 'package:get/get.dart';

import '../controllers/shipping_address_controller.dart';

class ShippingAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShippingAddressController>(
      () => ShippingAddressController(),
    );
  }
}
