import 'package:get/get.dart';
import 'package:mocci/app/data/Provider/provider.dart';
import 'package:mocci/app/modules/login/controllers/login_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
