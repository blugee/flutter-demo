import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/modules/myOrders/views/order_details_view.dart';
import '../controllers/my_orders_controller.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Orders',
            style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
          ),
        ),
        body: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => orderItem(),
          itemCount: 2,
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: kColors.DARK_GREY,
          ),
        ));
  }

  orderItem() {
    return GestureDetector(
      onTap: () => Get.to(() => OrderDetailsView(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 400)),
      child: Container(
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
                    blurRadius: 10,
                    offset: Offset(5, 2),
                    color: Color(0x37110303).withOpacity(0.3),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: customCacheNetwokImage(
                      'https://picsum.photos/seed/834/600', 20),
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
                        // fontFamily: 'Time New Roman',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: kColors.DARK_GREY,
              size: 24,
            )
          ],
        ),
      ),
    );
  }
}
