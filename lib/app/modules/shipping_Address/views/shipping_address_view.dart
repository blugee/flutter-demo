import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import '../controllers/shipping_address_controller.dart';

class ShippingAddressView extends GetView<ShippingAddressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: appBarTitle('Shipping Address')),
        body: GestureDetector(
          onTap: () => hideKeyboard(context),
          child: Container(
            height: Get.height,
            width: Get.width,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05),
                children: [
                  buildInputField(
                      isIcon: false,
                      title: 'Country',
                      textController: controller.country),
                  buildInputField(
                      isIcon: false,
                      title: 'State',
                      textController: controller.state),
                  buildInputField(
                      isIcon: false,
                      title: 'City',
                      textController: controller.city),
                  buildInputField(
                      isIcon: false,
                      title: 'Address 1',
                      textController: controller.address1),
                  buildInputField(
                      isIcon: false,
                      title: 'Address 2',
                      textController: controller.address2),
                  buildInputField(
                      isIcon: false,
                      title: 'Phone Number',
                      textController: controller.phoneNo),
                  SizedBox(height: Get.width / 2.5),
                  MainButton(
                    title: 'Save Address',
                    buttonColor: kColors.ERROR_YELLOW,
                    onPress: () {},
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
