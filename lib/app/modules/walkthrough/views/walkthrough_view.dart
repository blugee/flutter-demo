import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough>
    with TickerProviderStateMixin {
  PageController controller = PageController();

  int pageIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: kColors.GREY1,
        ),
        child: Stack(
          children: <Widget>[
            PageView(
              onPageChanged: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
              controller: controller,
              children: <Widget>[
                IntroPagesScreen(
                  screenImage: 'assets/images/img1.png',
                  heading: 'Shop',
                  subheading: """Select a jewelry design or design your own.
""",
                ),
                IntroPagesScreen(
                  screenImage: 'assets/images/img2.png',
                  heading: 'Customize',
                  subheading:
                      """Personalize your jewelry design in the materials of your choice.""",
                ),
                IntroPagesScreen(
                  screenImage: 'assets/images/img3.png',
                  heading: 'Order',
                  subheading:
                      """Have your jewelry shipped directly to your doorstep.""",
                ),
              ],
            ),
            Positioned(
              bottom: kDynamicWidth.width10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    // _dots(),
                    Padding(
                      padding: EdgeInsets.all(kDynamicWidth.width10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _dots(),
                          pageIndex != 2
                              ? InkWell(
                                  splashColor: Colors.transparent,
                                  child: _buildText("Next"),
                                  onTap: () {
                                    if (!(controller.page == 2.0))
                                      controller.nextPage(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.fastLinearToSlowEaseIn);
                                  },
                                )
                              : InkWell(
                                  splashColor: Colors.transparent,
                                  child: _buildText("Finish"),
                                  onTap: () async {
                                    await Get.offNamed(Routes.HOME);
                                  },
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _buildText(_t) {
    return Text(
      _t,
      style: TextStyle(
          color: kColors.DARK_GREY,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp),
    );
  }

  Row _dots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _circledots(pageIndex == 0
            ? kColors.ERROR_YELLOW
            : kColors.ERROR_YELLOW.withOpacity(0.3)),
        _circledots(pageIndex == 1
            ? kColors.ERROR_YELLOW
            : kColors.ERROR_YELLOW.withOpacity(0.3)),
        _circledots(pageIndex == 2
            ? kColors.ERROR_YELLOW
            : kColors.ERROR_YELLOW.withOpacity(0.3)),
      ],
    );
  }

  Widget _circledots(color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      width: 12.w,
      height: 12.w,
      child: Material(
        shape: CircleBorder(),
        color: color,
      ),
    );
  }
}

class IntroPagesScreen extends StatelessWidget {
  IntroPagesScreen({this.heading, this.screenImage, this.subheading});
  final String screenImage, heading, subheading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: Get.height / 1.6,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            image: DecorationImage(
                image: AssetImage(screenImage), fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: kDynamicWidth.width20, left: kDynamicWidth.width20),
          child: Text(
            heading,
            style: kTextStyle.f16w5.copyWith(
                color: kColors.DARK_BLUE,
                fontFamily: 'Time New Roman',
                fontSize: 30.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kDynamicWidth.width20,
              vertical: kDynamicWidth.width20),
          child: Text(
            subheading,
            textAlign: TextAlign.start,
            style: kTextStyle.f16w5
                .copyWith(fontSize: 20.sp, color: kColors.DARK_BLUE),
          ),
        ),
      ],
    );
  }
}
