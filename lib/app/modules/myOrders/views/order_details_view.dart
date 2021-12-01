import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/modules/myOrders/controllers/my_orders_controller.dart';

class OrderDetailsView extends GetView<MyOrdersController> {
  final MyOrdersController controller = Get.put(MyOrdersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _upperSection(),
              Divider(thickness: 1),
              middleSection(),
              Divider(thickness: 1),
              _middleSection2(),
              Divider(thickness: 1),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.w),
                  child: Stepper(
                      type: StepperType.vertical,
                      physics: ScrollPhysics(),
                      currentStep: controller.currentStep.value,
                      //  onStepTapped: (step) => tapped(step),
                      // onStepContinue:  continued,
                      //  onStepCancel: cancel,
                      steps: <Step>[
                        Step(
                          title: Text('Ordered'),
                          subtitle: _buildGreyText('Tue, July 27, 2021'),
                          content: Container(),
                        ),
                        Step(
                          title: Text('Packed'),
                          content: _buildGreyText('Tue, July 27, 2021'),
                        ),
                        Step(
                          title: Text('Shipping'),
                          content: _buildGreyText('Tue, July 27, 2021'),
                        ),
                        Step(
                          title: Text('Delivery'),
                          content: _buildGreyText('Tue, July 27, 2021'),
                        ),
                      ])),
              _bottomSection(),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
    );
  }

  Padding _bottomSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.0.w),
      child: Row(children: [
        _buildOutLinedButton('Cancel'),
        SizedBox(
          width: 10.w,
        ),
        _buildOutLinedButton('Need help?')
      ]),
    );
  }

  Expanded _buildOutLinedButton(_t) {
    return Expanded(
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: kColors.ERROR_YELLOW, width: 1.5)),
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: _buildTextForOrderDetails(_t),
            )));
  }

  Padding _middleSection2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.w),
      child: Column(
        children: [
          _buildTextForOrderDetails('Order details'),
          SizedBox(height: 5.h),
          _buildGreyText('Billing Address'),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  middleSection() => Container(
        height: Get.height * 0.15,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: Get.width * 0.22,
                height: Get.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: Offset(5, 0),
                      color: Color(0x37110303).withOpacity(0.3),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Hero(
                        tag: 'orderDetail',
                        child: customCacheNetwokImage(
                            'https://picsum.photos/seed/834/600', 20)),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(height: Get.width * 0.1),
                    Expanded(
                      child: Text(
                        'Delivery expected by Aug 01',
                        maxLines: 2,
                        softWrap: true,
                        style: kTextStyle.f18w6.copyWith(
                            fontSize: 15.sp, color: kColors.ERROR_YELLOW),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'The Italia Pendant',
                        style: kTextStyle.f16w5.copyWith(
                          fontSize: 18.sp,
                          color: kColors.DARKEST_NAVY,
                          fontFamily: 'Time New Roman',
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
      );

  Padding _upperSection() {
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: Column(
        children: [
          _buildTitleRow('Order ID', 'MOCCI232232'),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGreyText('Order created'),
              _buildGreyText('Tue,July 27,2021'),
            ],
          ),
          SizedBox(height: 25.h),
          _buildTitleRow('Total', '\$109,00S'),
        ],
      ),
    );
  }

  Text _buildGreyText(_t) => Text(
        _t,
        style: kTextStyle.f18w6
            .copyWith(fontSize: 14.sp, color: kColors.DARK_GREY),
      );

  Row _buildTitleRow(_l, _r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildTextForOrderDetails(_l), _buildTextForOrderDetails(_r)],
    );
  }

  Text _buildTextForOrderDetails(_t) {
    return Text(_t,
        style: kTextStyle.f16w5
            .copyWith(color: kColors.DARK_BLUE, fontWeight: FontWeight.w700));
  }
}
