import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';

import 'package:mocci/app/routes/app_pages.dart';
import '../controllers/search_screen_controller.dart';

class AfterSearchProductsView extends StatefulWidget {
  @override
  State<AfterSearchProductsView> createState() =>
      _AfterSearchProductsViewState();
}

class _AfterSearchProductsViewState extends State<AfterSearchProductsView> {
  final pendants = ['pen1.png', 'pen2.jpg', 'pen3.jpg', 'pen4.jpg'];

  final bracelets = ['brac1.jpg', 'brac2.jpeg', 'brac3.jpeg', 'brac4.jpg'];

  final rings = ['ring1.jpg', 'ring2.png', 'ring3.jpg', 'ring4.jpg'];

  final earrings = [
    'demoNecklace.jpg',
    'demoNecklace.jpg',
    'demoNecklace.jpg',
    'demoNecklace.jpg',
  ];

  final controller = Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: Get.height,
          width: Get.width,
          alignment: Alignment.center,
          child: LayoutBuilder(builder: (context, constraints) {
            return Obx(() {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      '${Get.arguments}',
                      style:
                          kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: kDynamicWidth.width16),
                        child: Icon(Icons.search_rounded),
                      )
                    ],
                  ),
                  SliverPadding(padding: EdgeInsets.only(top: 5)),
                  SliverToBoxAdapter(child: _filterHeader()),

                       SliverToBoxAdapter(
                          child:controller.isFilter.value ? ChipsChoice<String>.multiple(
                            value: giveTags(),
                            choiceActiveStyle: C2ChoiceStyle(
                                color: kColors.ERROR_YELLOW, pressElevation: 4),
                            onChanged: onChange,
                            choiceItems: C2Choice.listFrom<String, String>(
                              source: giveOptionsForFilter(),
                              value: (i, v) => v,
                              label: (i, v) => v,
                            ),
              ):
                           ChipsChoice<int>.single(
                            value: controller.sortingTag.value,
                            choiceActiveStyle: C2ChoiceStyle(
                                color: kColors.ERROR_YELLOW, pressElevation: 4),
                            onChanged: (val) {
                                controller.sortingTag.value = val;
                            },
                            choiceItems: C2Choice.listFrom<int, String>(
                              source: controller.sortingOptions,
                              value: (i, v) => i,
                              label: (i, v) => v,
                            ),
                          ),
                       ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.7,
                        crossAxisSpacing: constraints.maxWidth * 0.02,
                        mainAxisSpacing: constraints.maxWidth * 0.04,
                        crossAxisCount: 2),
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => GestureDetector(
                            onTap: () => Get.toNamed(Routes.PREVIEW_SCREEN),
                            child: Card(
                              elevation: 3,
                              child: Column(
                                children: [
                                  Container(
                                    height: 200.h,
                                    width: Get.width,
                                    child: Stack(
                                      children: [
                                        Container(
                                            child: Image.asset(
                                          giveListWidget(index),
                                          fit: BoxFit.cover,
                                          width: Get.width,
                                          height: Get.width / 2,
                                        )),
                                        Positioned(
                                          top: 5,
                                          left: kDynamicWidth.width10,
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            color: kColors.PINKIESH,
                                            child: Text(
                                              '50% OFF',
                                              style: kTextStyle.f12w4.copyWith(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: kDynamicWidth.width10,
                                          child: Icon(
                                            Icons.favorite_border_rounded,
                                            color: kColors.PINKIESH,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.all(kDynamicWidth.width10),
                                    width: 170.w,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${Get.arguments} ${index}',
                                          style: kTextStyle.f14w4.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: kColors.DARK_BLUE),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        childCount: 4),
                  ),
                  // _buildChip('Name', Colors.white),
                  // _buildChip('Zodiac', Colors.white),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       top: kDynamicWidth.width50 + kDynamicWidth.width20),
                  //   child: GridView.builder(
                  //     itemCount: 4,
                  //     primary: false,
                  //     // padding: EdgeInsets.all(kDynamicWidth.width20),
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         childAspectRatio: 0.7,
                  //         crossAxisSpacing: constraints.maxWidth * 0.02,
                  //         mainAxisSpacing: constraints.maxWidth * 0.04,
                  //         crossAxisCount: 2),
                  //     itemBuilder: (BuildContext context, int index) =>
                  //         GestureDetector(
                  //             onTap: () => Get.toNamed(Routes.PREVIEW_SCREEN),
                  //             child: Card(
                  //               elevation: 3,
                  //               child: Column(
                  //                 children: [
                  //                   Container(
                  //                     height: 200.h,
                  //                     width: Get.width,
                  //                     child: Stack(
                  //                       children: [
                  //                         Container(
                  //                             child: Image.asset(
                  //                           giveListWidget(index),
                  //                           fit: BoxFit.cover,
                  //                           width: Get.width,
                  //                           height: Get.width / 2,
                  //                         )
                  //                             // customCacheNetwokImage(
                  //                             //     "https://picsum.photos/seed/771/600", 20),
                  //                             ),
                  //                         Positioned(
                  //                           top: 5,
                  //                           left: kDynamicWidth.width10,
                  //                           child: Container(
                  //                             padding: EdgeInsets.all(2),
                  //                             color: kColors.PINKIESH,
                  //                             child: Text(
                  //                               '50% OFF',
                  //                               style: kTextStyle.f12w4.copyWith(
                  //                                   color: Colors.white),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Positioned(
                  //                           top: 5,
                  //                           right: kDynamicWidth.width10,
                  //                           child: Icon(
                  //                             Icons.favorite_border_rounded,
                  //                             color: kColors.PINKIESH,
                  //                           ),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     padding:
                  //                         EdgeInsets.all(kDynamicWidth.width10),
                  //                     width: 170.w,
                  //                     color: Colors.white,
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       children: [
                  //                         Text(
                  //                           '${Get.arguments} ${index}',
                  //                           style: kTextStyle.f14w4.copyWith(
                  //                               fontWeight: FontWeight.w600,
                  //                               color: kColors.DARK_BLUE),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 5.h,
                  //                         ),
                  //                         // Row(
                  //                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                         //   children: [
                  //                         //     Text(
                  //                         //       '\$99.00',
                  //                         //       style: kTextStyle.f14w4.copyWith(
                  //                         //           color: kColors.DARK_GREY,
                  //                         //           decoration: TextDecoration.lineThrough),
                  //                         //     ),
                  //                         //     Text(
                  //                         //       '\$99.00',
                  //                         //       style: kTextStyle.f18w6.copyWith(
                  //                         //           fontWeight: FontWeight.w800,
                  //                         //           color: kColors.ERROR_YELLOW),
                  //                         //     ),
                  //                         //   ],
                  //                         // ),
                  //                       ],
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             )),
                  //   ),
                  // )
                ],
              );
            });
          })),
    );
  }

  Container _filterHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width / 6, vertical: kDynamicWidth.width10),
      decoration: BoxDecoration(
          color: Colors.white54,
          border: Border.all(color: kColors.DARK_GREY, width: 0.5)),
      height: Get.width / 6,
      width: Get.width,
      child: Row(
        children: [
          InkWell(
              onTap: () {
                controller.isFilter.value = true;
              },
              child: buildRow(Icons.filter_alt_outlined, 'Filter')),
          Spacer(),
          VerticalDivider(),
          Spacer(),
          InkWell(
              onTap: () {
                controller.isFilter.value = false;
              },
              child: buildRow(Icons.sort_by_alpha_outlined, 'Sort')),
        ],
      ),
    );
  }

  String giveListWidget(index) {
    if (Get.arguments == 'Rings') {
      return 'assets/images/${rings[index]}';
    } else if (Get.arguments == 'Bracelet') {
      return 'assets/images/${bracelets[index]}';
    } else if (Get.arguments == 'Pendants') {
      return 'assets/images/${pendants[index]}';
    } else {
      return 'assets/images/${earrings[index]}';
    }
  }

  List<String> giveTags() {
    if (Get.arguments == 'Rings') {
      return controller.ringTag;
    } else if (Get.arguments == 'Bracelet') {
      return controller.braceletTag;
    } else if (Get.arguments == 'Pendants') {
      return controller.pendantsTag;
    } else {
      return controller.earringTag;
    }
  }

  List<String> giveOptionsForFilter() {
    if (Get.arguments == 'Rings') {
      return controller.ringsOptions;
    } else if (Get.arguments == 'Bracelet') {
      return controller.braceletOptions;
    } else if (Get.arguments == 'Pendants') {
      return controller.pendantsOptions;
    } else {
      return controller.earringsOptions;
    }
  }


   onChange(val) {
    if (Get.arguments == 'Rings') {
      return setState(() {
        controller.ringTag = val;
      });
    } else if (Get.arguments == 'Bracelet') {
      return setState(() {
        controller.braceletTag = val;
      });
    } else if (Get.arguments == 'Pendants') {
      return setState(() {
        controller.pendantsTag = val;
      });
    } else {
      return setState(() {
        controller.earringTag = val;
      });
    }
  }



  Row buildRow(_icon, _title) {
    return Row(
      children: [
        Icon(
          _icon,
          size: 18,
          color: kColors.DARK_BLUE,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          _title,
          style: kTextStyle.f16w5
              .copyWith(color: kColors.DARK_BLUE, fontWeight: FontWeight.w400),
        )
      ],
    );
  }


}
