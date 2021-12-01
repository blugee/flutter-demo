import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mocci/app/data/LocalStorage/localStorage.dart';
import 'package:mocci/app/data/Models/getProducts_Model.dart';

import 'package:mocci/app/data/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/profile/controllers/profile_controller.dart';
import 'package:mocci/app/modules/searchScreen/views/after_searchProduct.dart';

import 'package:mocci/app/modules/searchScreen/views/searchScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocci/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final localStorage = LocalStorage();

  void onTabTapped(int index) {
    HomeController.to.currentIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
        child: Scaffold(
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                currentIndex: HomeController.to.currentIndex.value,
                onTap: onTabTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/images/explore.svg'),
                    activeIcon: SvgPicture.asset(
                      'assets/images/explore.svg',
                      color: kColors.ERROR_YELLOW,
                    ),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_rounded),
                    activeIcon: Icon(Icons.favorite),
                    label: 'Wishlist',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    activeIcon: Icon(Icons.shopping_cart_rounded),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_rounded),
                    activeIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
            body: Obx(() => HomeController.to.children
                .elementAt(HomeController.to.currentIndex.value))));
  }
}

class ExploreView extends GetView<HomeController> {
  final ExploreScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: ExploreScaffoldKey,
        drawer: _ExploreViewDrawer(),
        appBar: AppBar(
          backgroundColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            return states.contains(MaterialState.scrolledUnder)
                ? kColors.SHADOW_COLOR.withOpacity(0.1)
                : Colors.white;
          }),
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(9.w),
            child: GestureDetector(
              onTap: () => ExploreScaffoldKey.currentState.openDrawer(),
              child: SvgPicture.asset(
                'assets/images/splash.svg',
                color: kColors.ERROR_YELLOW,
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.notifications_none_rounded)),
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: IconButton(
                  onPressed: () => Get.to(() => SearchScreen(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 300)),
                  icon: Icon(Icons.search)),
            ),
          ],
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: LayoutBuilder(
              builder: (context, BoxConstraints) => Obx(() {
                    return SmartRefresher(
                      controller: controller.refreshController,
                      header: BezierCircleHeader(
                        bezierColor: kColors.SHADOW_COLOR,
                      ),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      onRefresh: controller.onRefresh,
                      child: ListView(shrinkWrap: true, children: _sliverList()
                          // SliverAppBar(
                          //   forceElevated: true,
                          //   floating: true,
                          //   // backgroundColor: MaterialStateColor.resolveWith(
                          //   //     (Set<MaterialState> states) {
                          //   //   return states.contains(MaterialState.scrolledUnder)
                          //   //       ? Colors.white
                          //   //       : Colors.transparent;
                          //   // }),
                          //   // snap: true,
                          //   // elevation: 0,
                          //   // leading: Padding(
                          //   //   padding: EdgeInsets.all(9.w),
                          //   //   child: GestureDetector(
                          //   //     onTap: (){},
                          //   //     child: SvgPicture.asset(
                          //   //       'assets/images/splash.svg',
                          //   //       color: kColors.ERROR_YELLOW,
                          //   //     ),
                          //   //   ),
                          //   // ),
                          //   // actions: [
                          //   //   IconButton(
                          //   //       onPressed: () {},
                          //   //       icon: Icon(Icons.notifications_none_rounded)),
                          //   //   Padding(
                          //   //     padding: EdgeInsets.only(right: 8.w),
                          //   //     child: IconButton(
                          //   //         onPressed: () {
                          //   //           Get.to(() => SearchScreen(),
                          //   //               transition: Transition.fadeIn,
                          //   //               duration:
                          //   //                   const Duration(milliseconds: 300));
                          //   //         },
                          //   //         icon: Icon(Icons.search)),
                          //   //   ),
                          //   // ],
                          // ),
                          // SliverPadding(padding: EdgeInsets.only(top: 5)),
                          //  SliverList(
                          //    delegate: SliverChildListDelegate(_sliverList()),
                          //  )

                          ),
                    );
                  })),
        ));
  }

  Drawer _ExploreViewDrawer() {
    final logic = Get.find<ProfileController>();
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: DrawerHeader(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: Get.width * 0.3,
                      height: Get.width * 0.3,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: kColors.SHADOW_COLOR,
                        shape: BoxShape.circle,
                      ),
                      child: logic.isLoggedIn.value
                          ? customCacheNetwokImage(
                              'https://picsum.photos/seed/441/600', 20)
                          : Icon(
                              Icons.person,
                              color: kColors.DARK_BLUE,
                            ),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: logic.isLoggedIn.value ? true : false,
                      child: Text(
                        '${LocalStorage().FIRST_NAME() ?? 'Name'} ${LocalStorage().LAST_NAME() ?? ''}',
                        style: kTextStyle.f18w6
                            .copyWith(color: kColors.ERROR_YELLOW),
                      ),
                    ),
                    Visibility(
                      visible: logic.isLoggedIn.value ? false : true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _drawerLoginSIgnUPButton('Login',
                              onTap: () => Get.toNamed(Routes.LOGIN)),
                          Text('Or'),
                          _drawerLoginSIgnUPButton('Signup',
                              onTap: () => Get.toNamed(Routes.SIGNUP)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  listTileForDrawer(
                      'Profile & Settings', 'assets/images/setting.svg', () {}),
                  listTileForDrawer('Orders', 'assets/images/orderHis.svg',
                      () => Get.toNamed(Routes.MY_ORDERS)),
                  listTileForDrawer(
                      'Invite Friends', 'assets/images/refer.svg', () {}),
                  Spacer(),
                  Text("V ${logic.verBuildNumber}", style: kTextStyle.f12w4)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextButton _drawerLoginSIgnUPButton(_T, {onTap}) {
    return TextButton(
        onPressed: onTap,
        child: Text(_T,
            style: kTextStyle.f18w6.copyWith(color: kColors.ERROR_YELLOW)));
  }

  _sliverList() {
    return <Widget>[
      _topCarouselSlider(),
      Center(
        child: DotsIndicator(
          reversed: false,
          dotsCount: 4,
          position: controller.caraousalIndex.value.toDouble(),
          decorator: DotsDecorator(
            activeColor: kColors.ERROR_YELLOW,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ),
      _buildTitle("Categories"),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: kDynamicWidth.width10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _Categories("Pendants", 'assets/images/jewelry.svg',
                onTap: () => Get.to(() => AfterSearchProductsView(),
                    arguments: 'Pendants')),
            _Categories("Rings", 'assets/images/ring.svg',
                onTap: () => Get.to(() => AfterSearchProductsView(),
                    arguments: 'Rings')),
            _Categories("Bracelets", 'assets/images/bracelet.svg',
                onTap: () => Get.to(() => AfterSearchProductsView(),
                    arguments: 'Bracelet')),
            _Categories("Earrings", 'assets/images/neck.svg',
                onTap: () => Get.to(() => AfterSearchProductsView(),
                    arguments: 'Earrings')),
          ],
        ),
      ),
      //SizedBox(height: kDynamicWidth.width20),
      //Image.asset('assets/images/dummy2.png'),
      SizedBox(height: kDynamicWidth.width20),
      _headingRow("New Designs", tap: () {}),
      _productList(),
      _headingRow("Best Selling Rings", tap: () {}),
      _productList(),
      _headingRow("Best Selling Earrings", tap: () {}),
      _productList(),
      _headingRow("Best Selling Bracelet", tap: () {}),
      _productList(),
      _buildTitle("Why Mocci"),
      _buildWhyMocci(),
      _buildWhyMocci(),
      _buildWhyMocci(),
      _buildTitle("Customer Says"),

      /// CUSTOMERS SAYS LIST
      Container(
        constraints: BoxConstraints.tightFor(width: 200, height: 255),
        height: 255.h,
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: kDynamicWidth.width20),
            separatorBuilder: (context, index) =>
                SizedBox(width: kDynamicWidth.width10),
            itemBuilder: (context, index) => buildCustomerComponent()),
      ),
      SizedBox(height: 30.h)
    ];
  }

  Row _headingRow(_title, {tap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildTitle(_title), _buildViewAll(onTap: tap)],
    );
  }

  Container _productList() {
    return Container(
      height: 280.h,
      child: PagedListView<int, MyProduct>(
        pagingController: controller.pagingController,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: kDynamicWidth.width20),
        // separatorBuilder: (context, index) =>
        //     SizedBox(width: kDynamicWidth.width10),
        builderDelegate: PagedChildBuilderDelegate<MyProduct>(
            firstPageProgressIndicatorBuilder: (_) => mocciLoader(35),
            newPageProgressIndicatorBuilder: (_) => mocciLoader(35),
            noItemsFoundIndicatorBuilder: (_) => NoItemsFoundIndicator(),
            itemBuilder: (context, item, index) {
              /// product img length for next screen
              var productPhotosLength = item.productUrl.length;
              return GestureDetector(
                onTap: () => Get.toNamed(Routes.PRODUCT_DETAIL, arguments: [
                  item.productUrl,
                  item.name,
                  item.description,
                  productPhotosLength
                ]),
                child: Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: 180.w, height: 280.h),
                                child: customCacheNetwokImage(
                                    '${kApiTexts.BASE_URL}${item.productUrl[0]}' ??
                                        '',
                                    35)),
                            Positioned(
                              top: 5,
                              left: kDynamicWidth.width10,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                color: kColors.PINKIESH,
                                child: Text(
                                  '50% OFF',
                                  style: kTextStyle.f12w4
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: kDynamicWidth.width10,
                              child: Obx(() {
                                return GestureDetector(
                                  onTap: () => controller.isFav.toggle(),
                                  child: AnimatedCrossFade(
                                    duration: const Duration(milliseconds: 400),
                                    firstChild: Icon(
                                      Icons.favorite_border,
                                      color: kColors.PINKIESH,
                                    ),
                                    secondChild: Icon(
                                      Icons.favorite_rounded,
                                      color: kColors.PINKIESH,
                                    ),
                                    crossFadeState: controller.isFav.value
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(kDynamicWidth.width10),
                          width: 170.w,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${item.name}'.capitalizeFirst ?? '',
                                style: kTextStyle.f14w4.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: kColors.DARK_BLUE),
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$99.00',
                                    style: kTextStyle.f14w4.copyWith(
                                        color: kColors.DARK_GREY,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    '\$${item.price}' ?? '23',
                                    style: kTextStyle.f18w6.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: kColors.ERROR_YELLOW),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Padding _buildWhyMocci() {
    return Padding(
      padding: EdgeInsets.only(
        left: kDynamicWidth.width20,
        right: kDynamicWidth.width20,
        bottom: kDynamicWidth.width20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            elevation: 6,
            shadowColor: kColors.SHADOW_COLOR,
            child: Container(
              height: Get.width / 4.6,
              width: Get.width / 4.6,
              child: SvgPicture.asset(
                'assets/images/certified.svg',
              ),
            ),
          ),
          SizedBox(width: kDynamicWidth.width10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '100% Certified Jewellery',
                style: kTextStyle.f14w4.copyWith(
                    fontWeight: FontWeight.w700, color: kColors.DARK_BLUE),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  width: Get.width / 2,
                  child: Text(
                    "Every piece you get is fully checked for quality and authenticity by reputed agencies.",
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    style: kTextStyle.f12w4.copyWith(color: kColors.DARK_GREY),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Padding _buildTitle(_t) {
    return Padding(
      padding: EdgeInsets.all(kDynamicWidth.width20),
      child: Text(
        _t,
        style: kTextStyle.f18w6
            .copyWith(fontSize: 17.sp, color: kColors.ERROR_YELLOW),
      ),
    );
  }

  Padding _buildViewAll({onTap}) {
    return Padding(
      padding: EdgeInsets.all(kDynamicWidth.width20),
      child: InkWell(
        onTap: onTap,
        child: Text(
          'View All',
          style: kTextStyle.f13w5.copyWith(color: kColors.ERROR_YELLOW),
        ),
      ),
    );
  }

  Widget _Categories(String _title, String _image, {var onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shadowColor: kColors.SHADOW_COLOR,
        child: Container(
          height: 67.h,
          width: 67.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(_image),
              Text(_title,
                  style: kTextStyle.f14w4
                      .copyWith(fontSize: 10.sp, color: kColors.DARK_BLUE))
            ],
          ),
        ),
      ),
    );
  }

  Widget _topCarouselSlider() {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              controller.caraousalIndex.value = index;
            },
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            scrollDirection: Axis.horizontal,
          ),
          itemCount: 4,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Padding(
            padding: EdgeInsets.symmetric(horizontal: kDynamicWidth.width16),
            child: Card(
              elevation: 4,
              shadowColor: kColors.SHADOW_COLOR,
              child: Container(
                height: 150.h,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/dummy1.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
        //     Obx(
        //       () => Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //                         Container(
        //               width: 8.0,
        //               height: 8.0,
        //               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        //               decoration: BoxDecoration(
        //                   shape: BoxShape.circle,
        //                   color: controller.caraousalIndex.value == index
        //                       ? Color.fromRGBO(0, 0, 0, 0.9)
        //                       : Color.fromRGBO(0, 0, 0, 0.4)),
        // )]
        // ))},
        //         ),
      ],
    );
  }

  Widget buildCustomerComponent() {
    final double _circleRadius = 0.18.sw;
    return Container(
      height: 280.h,
      width: 250.w,
      color: Colors.transparent,
      child: Stack(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(kDynamicWidth.width10),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: _circleRadius / 2.0,
                ),

                ///here we create space for the circle avatar to get ut of the box
                child: Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0.0, 5.0),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: _circleRadius / 2,
                        ),
                        Text(
                          'Username',
                          style: kTextStyle.f14w4.copyWith(
                              color: kColors.DARK_BLUE,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: _circleRadius / 4,
                        ),
                        Text(
                          'Every piece you get is fully checked for quality and authenticity by reputed agencies.',
                          style: kTextStyle.f12w4
                              .copyWith(color: kColors.DARK_GREY),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///Image Avatar
              Container(
                width: _circleRadius,
                height: _circleRadius,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: customCacheNetwokImage(
                    'https://picsum.photos/seed/185/600', 20),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  NoItemsFoundIndicator() {
    return Column(children: [
      Icon(Icons.search, color: kColors.DARK_BLUE, size: 20),
      Text(
        'Sorry ! No items Found.',
        style: kTextStyle.f14w4.copyWith(color: kColors.DARK_BLUE),
      )
    ]);
  }
}
