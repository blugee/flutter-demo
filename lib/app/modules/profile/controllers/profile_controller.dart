import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find<ProfileController>();
  RxBool isLoggedIn = false.obs;
  final appStorage = GetStorage();
  String verBuildNumber;

  checkAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    verBuildNumber = '${packageInfo.version} (${packageInfo.buildNumber})';
  }

  checkLoginStatus() {
    if (appStorage.read('isLoggedIn') == true &&
        appStorage.read('isLoggedIn') != null) {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    checkAppVersion();
  }
}
