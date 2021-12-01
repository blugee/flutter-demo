import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';

class ZoomView extends StatelessWidget {
  final String _productImg = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => Get.back(),
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
        backgroundColor: kColors.ERROR_YELLOW,
      ),
      body: Center(
        child: Container(
          height: Get.height / 2,
          width: Get.width,
          child: Hero(
            tag: '$_productImg',
            child: InteractiveViewer(
              child: customCacheNetwokImage(_productImg, 35),
            ),
          ),
        ),
      ),
    );
  }
}
