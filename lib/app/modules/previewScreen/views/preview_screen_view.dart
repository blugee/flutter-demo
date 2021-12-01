import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mocci/app/data/Models/shape_way_materials.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocci/app/modules/home/controllers/home_controller.dart';
import 'package:mocci/app/modules/previewScreen/controllers/preview_screen_controller.dart';
import 'package:mocci/app/modules/searchScreen/controllers/search_screen_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class PreviewScreenView extends StatefulWidget {
  @override
  _PreviewScreenViewState createState() => _PreviewScreenViewState();
}

class _PreviewScreenViewState extends State<PreviewScreenView> {
  final controller = Get.put(PreviewScreenController());

  Future<ui.Image> loadUiImage(String url) async {
    final response = await http.get(Uri.parse(url));
    response.bodyBytes;
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(response.bodyBytes, completer.complete);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Preview',
            style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
          ),
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: LayoutBuilder(
            builder: (context, constraints) => Obx(() {
              return ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/dummy5.png'),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Center(
                          child: FutureBuilder<ui.Image>(
                              future: loadUiImage(controller.matImage ??
                                  'https://static1.sw-cdn.net/rrstatic/img/materials/swatch-orange.png'),
                              builder: (context, img) {
                                return img.hasData
                                    ? ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (bounds) => ImageShader(
                                          img.data,
                                          TileMode.clamp,
                                          TileMode.clamp,
                                          Matrix4.identity().storage,
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            '${controller.previewText.value.isNotEmpty ? controller.previewText.value.trim() : 'Type Text'}',
                                            style: GoogleFonts.pacifico(
                                                fontSize: controller
                                                            .previewText.value
                                                            .trim()
                                                            .length <=
                                                        3
                                                    ? 75.sp
                                                    : 55.sp,
                                                height: 5.h,
                                                fontWeight: FontWeight.values[
                                                    controller
                                                        .thicknessSlider.value
                                                        .toInt()]),
                                          ),
                                        ),
                                      )
                                    : Text('');
                              }),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(kDynamicWidth.width20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildTextFormField(),
                        SizedBox(
                          height: kDynamicWidth.width20,
                        ),
                        // Row(children: [
                        //   _buildText('Size'),
                        //   Spacer(),
                        // Slider(
                        //     value: controller.sizeSlider.value,
                        //     min: 30,
                        //     max: 100,
                        //     divisions: 10,
                        //     label: controller.sizeSlider.value.round().toString(),
                        //     onChanged: (double value) =>
                        //         controller.sizeSlider.value = value)
                        // ]),
                        // Row(children: [
                        //   _buildText('Thickness'),
                        //   Spacer(),
                        //   // _thicknessSlider()
                        // ]),
                        SizedBox(height: constraints.maxHeight * 0.03),
                        _buildDropdownButton(),
                        SizedBox(height: constraints.maxHeight * 0.04),
                        controller.previewText.value.isNotEmpty
                            ? _totalCost()
                            : SizedBox(height: 0),
                        SizedBox(height: constraints.maxHeight * 0.03),

                        MainButton(
                            title: 'Add to Cart',
                            buttonColor: kColors.ERROR_YELLOW,
                            onPress: () =>
                                controller.addedToCartBottomSheet(context))
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }

  totalCostCalculator() =>
      controller.totalCost.value = controller.previewText.value.length * 0.5;

  Row _totalCost() {
    return Row(children: [
      _buildText('Total Cost'),
      Spacer(),
      Text(totalCostCalculator().toString(),
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: kTextStyle.f18w6.copyWith(color: kColors.ERROR_YELLOW)),
      SizedBox(width: 5.w),
      _buildText('\$')
    ]);
  }

  DropdownButton<ShapewayMaterials> _buildDropdownButton() {
    return DropdownButton(
        isExpanded: true,
        underline: SizedBox(
          height: 0,
        ),
        value: controller.selectedMaterial,
        style: kTextStyle.f18w6
            .copyWith(color: kColors.DARK_BLUE, fontFamily: 'Carmen Sans'),
        iconSize: 35,
        hint: _buildText('Select Material'),
        onChanged: (newValue) {
          setState(() {
            controller.selectedMaterial = newValue;
            controller.matImage = controller.selectedMaterial.swatch;
            controller.materialId =
                int.parse(controller.selectedMaterial.materialId);
            assert(controller.materialId is int);
            print(controller.materialId);
          });
        },
        items: controller.materialsListFromShapeway != null
            ? controller.materialsListFromShapeway
                .map((ShapewayMaterials val) => _buildDropdownMenuItem(val))
                .toList()
            : null);
  }

  Slider _thicknessSlider() {
    return Slider(
        value: controller.thicknessSlider.value,
        min: 0,
        max: 8,
        divisions: 8,
        label: controller.thicknessSlider.value.round().toString(),
        onChanged: (double value) => controller.thicknessSlider.value = value);
  }

  DropdownMenuItem<ShapewayMaterials> _buildDropdownMenuItem(
      ShapewayMaterials val) {
    return DropdownMenuItem(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  child: CachedNetworkImage(
                    errorWidget: (BuildContext, String, dynamic) =>
                        Icon(Icons.error),
                    imageUrl: val.swatch,
                    placeholder: (context, _) => Center(
                        child: SpinKitFadingCube(
                      color: kColors.ERROR_YELLOW,
                      size: 15.w,
                    )),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Text(
                    val.title,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  )),
            ],
          ),
          Divider(
            color: kColors.ERROR_YELLOW,
          )
        ],
      ),
      value: val,
    );
  }

  Text _buildText(_t) {
    return Text(_t, style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE));
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      autofocus: false,
      controller: controller.namePreview,
      onChanged: (newVal) {
        controller.previewText.value = newVal;
      },
      decoration: InputDecoration(
          hintText: 'Enter your Text',
          labelStyle: keyboardFont,
          hintStyle: kTextStyle.f16w5.copyWith(
            color: kColors.DARK_GREY,
          ),
          suffix: GestureDetector(
              child: Icon(Icons.clear_rounded),
              onTap: () => controller.namePreview.clear()),
          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
      cursorColor: kColors.ERROR_YELLOW,
      textInputAction: TextInputAction.done,
      style: keyboardFont,
      maxLines: 1,
      keyboardType: TextInputType.name,
    );
  }
}

TextStyle keyboardFont =
    kTextStyle.f14w4.copyWith(color: kColors.DARK_BLUE, fontSize: 16.sp);
