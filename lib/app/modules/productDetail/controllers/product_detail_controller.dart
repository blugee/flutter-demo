import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocci/app/data/LocalStorage/localStorage.dart';
import 'package:mocci/app/data/Models/shape_way_materials.dart';
import 'package:mocci/app/data/Repository/repository.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/home/controllers/home_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailController extends GetxController {
  var productImage = Get.arguments[0];
  var productName = Get.arguments[1];
  var productDescription = Get.arguments[2];
  var pdtPhotosLength = Get.arguments[3];
  RxInt carasolPageIndex = 0.obs;
  final pinCodeCont = TextEditingController();
  final buttonCarouselController = CarouselController();
  final appStorage = GetStorage();
  final _repository = Repository();

  RxList<dynamic> materialList = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  List<ShapewayMaterials> getMaterialsFromJson(materials) {
    materials.forEach((key, value) {
      materialList.add(value);

      ///Every material
    });
    materialList.length;
    List<ShapewayMaterials> myList = [];
    for (int i = 0; i < materialList.length; i++) {
      ShapewayMaterials data = ShapewayMaterials(
          materialId: materialList[i]['materialId'],
          title: materialList[i]['title'],
          supportsColorFiles: materialList[i]['supportsColorFiles'],
          swatch: materialList[i]['swatch'],
          restrictions: materialList[i]['restrictions']);
      myList.add(data);
    }

    print(materialList);
    return myList;
  }

  getMaterialsFromShapeway() async {
    var _accessToken = appStorage.read('accessToken');

    try {
      if (_accessToken != null) {
        await _repository
            .getMaterialsFromShapeway(_accessToken)
            .then((value) async {
          if (value['result'] == 'success') {
            var _mat = appStorage.read('materials');
            var data = await getMaterialsFromJson(_mat['materials']);
            Get.toNamed(Routes.PREVIEW_SCREEN, arguments: data);
          }
        });
      } else {
        _buildBottomSheet(Get.context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> _buildBottomSheet(BuildContext context) {
    return Get.bottomSheet(
      Container(
        height: Get.height / 2.5,
        width: Get.width,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Please Login or Signup',
              style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
            ),
            Expanded(child: SvgPicture.asset('assets/images/login.svg')),
            MainButton(
              title: 'Login / Signup',
              onPress: () {
                HomeController.to.currentIndex.value = 3;
                Get.offNamed(Routes.HOME);
              },
              buttonColor: kColors.ERROR_YELLOW,
            )

          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    pinCodeCont.dispose();
  }

  Future<dynamic> MakeThisYours() async {
    Get.showOverlay(
        asyncFunction: () => getMaterialsFromShapeway(),
        loadingWidget: mocciLoader(35));
  }
}
