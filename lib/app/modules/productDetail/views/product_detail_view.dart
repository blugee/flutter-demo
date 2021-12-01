import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/productDetail/controllers/product_detail_controller.dart';
import 'package:mocci/app/modules/productDetail/views/zoomView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocci/app/routes/app_pages.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              kDynamicWidth.width20, 0, kDynamicWidth.width20, 0),
          child: MainButton(
            title: 'Make this Yours',
            buttonColor: kColors.ERROR_YELLOW,
            onPress: () => controller.MakeThisYours(),
          ),
        ),
      ],
      body: Container(
        height: Get.height,
        width: Get.width,
        child: LayoutBuilder(builder: (context, constraints) {
          return SafeArea(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    return states.contains(MaterialState.scrolledUnder)
                        ? Colors.white
                        : Colors.transparent;
                  }),
                  elevation: 0,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 25.w),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: kColors.PINKIESH,
                      ),
                    ),
                  ],
                ),
                SliverPadding(padding: EdgeInsets.only(top: 5)),
                SliverList(
                  delegate: SliverChildListDelegate([_ContentList(context)]),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Column _ContentList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topCarasol(),
        SizedBox(
          height: kDynamicWidth.width10,
        ),
        Center(
          child: Obx(() {
            return DotsIndicator(
              dotsCount: controller.pdtPhotosLength,
              position: controller.carasolPageIndex.value.toDouble(),
              decorator: DotsDecorator(
                activeColor: kColors.ERROR_YELLOW,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          }),
        ),
        _buildContentTexts(context),
        // Padding(
        //   padding: EdgeInsets.fromLTRB(
        //       kDynamicWidth.width20, 0, kDynamicWidth.width20, 0),
        //   child: MainButton(
        //     title: 'Make this Yours',
        //     buttonColor: kColors.ERROR_YELLOW,
        //     onPress: () => controller.MakeThisYours(),
        //   ),
        // ),
      ],
    );
  }

  _buildContentTexts(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDynamicWidth.width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${controller.productName}'.capitalizeFirst,
            maxLines: 3,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
                color: kColors.DARK_BLUE),
          ),
          SizedBox(
            height: kDynamicWidth.width10,
          ),
          Html(
            data: controller.productDescription,
          ),
          SizedBox(
            height: kDynamicWidth.width50,
          ),
          // _pinCodeRow(),
        ],
      ),
    );
  }

  // Row _pinCodeRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Icon(
  //         Icons.location_on_outlined,
  //         color: kColors.DARK_GREY,
  //       ),
  //       Text(
  //         "Your Pincode",
  //         style: kTextStyle.f14w4.copyWith(
  //           color: kColors.DARK_BLUE,
  //         ),
  //       ),
  //       Container(
  //         width: Get.width / 2,
  //         height: 44.h,
  //         decoration: BoxDecoration(
  //           border: Border.all(color: kColors.DARK_GREY),
  //           color: kColors.GREY_2,
  //         ),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.max,
  //           children: [
  //             Expanded(
  //               child: TextFormField(
  //                 autofocus: false,
  //                 controller: controller.pinCodeCont,
  //                 decoration: InputDecoration(
  //                   hintText: 'Pincode',
  //                   hintStyle:
  //                       kTextStyle.f14w4.copyWith(color: kColors.DARK_GREY),
  //                   enabledBorder: InputBorder.none,
  //                   focusedBorder: InputBorder.none,
  //                   contentPadding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
  //                 ),
  //                 style: kTextStyle.f14w4.copyWith(color: kColors.DARK_BLUE),
  //                 maxLines: 1,
  //                 keyboardType: TextInputType.number,
  //               ),
  //             ),
  //             VerticalDivider(),
  //             Expanded(
  //               child: Text(
  //                 'Change',
  //                 style: kTextStyle.f14w4.copyWith(color: kColors.ERROR_YELLOW),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget topCarasol() {
    return CarouselSlider.builder(
      carouselController: controller.buttonCarouselController,
      options: CarouselOptions(
        onPageChanged: (int, _) {
          controller.carasolPageIndex.value = int;
        },
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: true,
        disableCenter: true,
        aspectRatio: 16 / 8,
        pauseAutoPlayOnManualNavigate: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        scrollDirection: Axis.horizontal,
      ),
      itemCount: controller.pdtPhotosLength,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        String productImg =
            "${kApiTexts.BASE_URL}${controller.productImage[itemIndex]}";
        return GestureDetector(
          onTap: () async =>
              await Get.to(() => ZoomView(), arguments: productImg),
          child: Hero(
              tag: '$productImg${itemIndex}',
              child: Container(
                width: Get.width,
                child: Material(
                  elevation: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: productImg,
                      fit: BoxFit.contain,
                      placeholder: (BuildContext, String) => mocciLoader(25),
                      errorWidget: (BuildContext, String, dynamic) =>
                          Icon(Icons.error_outline_outlined),
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }

  Container _buildNextPrevbuttons(ontap, icon) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: kColors.PINKIESH, borderRadius: BorderRadius.circular(15)),
      child: GestureDetector(
        onTap: ontap,
        child: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
