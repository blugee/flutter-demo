import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/Models/shape_way_materials.dart';
import 'package:mocci/app/data/Models/uploadShapeWay_model.dart';
import 'package:mocci/app/data/Repository/repository.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/home/controllers/home_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';

class PreviewScreenController extends GetxController {
  final namePreview = TextEditingController();
  RxString previewText = ''.obs;
  RxDouble totalCost = 0.0.obs;
  RxDouble sizeSlider = 30.0.obs;
  RxDouble thicknessSlider = 0.0.obs;
  String matImage;
  var materialId;
  List<ShapewayMaterials> materialsListFromShapeway = [];
  ShapewayMaterials selectedMaterial;
  final repo = Repository();

  @override
  void onInit() {
    super.onInit();
    try {
      ///here we add all elements from argument list to [materialsListFromShapeWay]
      materialsListFromShapeway.addAll(Get.arguments);

      ///and assign to [index] 0
      ShapewayMaterials selectedMaterial = ShapewayMaterials(
          materialId: "90",
          title: "Polished and Bronzed Black Steel",
          supportsColorFiles: false,
          printerId: "6",
          swatch:
              "https://static1.sw-cdn.net/rrstatic/img/materials/swatch-steel-polished-gray-20131023.png",
          restrictions: null);
      materialsListFromShapeway.insert(0, selectedMaterial);
      selectedMaterial = materialsListFromShapeway[0];
    } catch (e) {}
  }

  // Future<dynamic> addToCart(BuildContext context) async {
  //   Get.showOverlay(
  //       asyncFunction: () => uploadModeltoShapeway(context),
  //       loadingWidget: mocciLoader());
  // }

  @override
  void onClose() {
    namePreview.dispose();
    super.onClose();
  }
  //
  // uploadModeltoShapeway(BuildContext context) async {
  //   try {
  //     await repo
  //         .uploadShapeWayModel(
  //             namePreview.text.trim(), namePreview.text.trim(), materialId)
  //         .then((UploadModel value) {
  //       if (value.result == 'success') {
  //         _buildBottomSheet(context);
  //       }
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<dynamic> addedToCartBottomSheet(BuildContext context) {
    return Get.bottomSheet(
      Container(
        height: 200.h,
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
              'Your Cart',
              style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
            ),
            Text(
              'Your Customized Jewellery pendant added to cart successfully.',
              style: kTextStyle.f16w5.copyWith(color: kColors.DARK_GREY),
            ),
            MainButton(
              title: 'View Cart',
              onPress: () {
                HomeController.to.currentIndex.value = 2;
                Get.offNamed(Routes.HOME);
              },
              buttonColor: kColors.ERROR_YELLOW,
            )
          ],
        ),
      ),
    );
  }
}
