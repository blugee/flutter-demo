import 'package:get/get.dart';

import 'package:mocci/app/modules/account/bindings/account_binding.dart';
import 'package:mocci/app/modules/account/views/account_view.dart';
import 'package:mocci/app/modules/creditCard/bindings/credit_card_binding.dart';
import 'package:mocci/app/modules/creditCard/views/credit_card_view.dart';
import 'package:mocci/app/modules/forgotPass/bindings/forgot_pass_binding.dart';
import 'package:mocci/app/modules/forgotPass/views/forgot_pass_view.dart';
import 'package:mocci/app/modules/home/bindings/home_binding.dart';
import 'package:mocci/app/modules/home/views/home_view.dart';
import 'package:mocci/app/modules/login/bindings/login_binding.dart';
import 'package:mocci/app/modules/login/views/login_view.dart';
import 'package:mocci/app/modules/myCart/bindings/my_cart_binding.dart';
import 'package:mocci/app/modules/myCart/views/my_cart_view.dart';
import 'package:mocci/app/modules/myOrders/bindings/my_orders_binding.dart';
import 'package:mocci/app/modules/myOrders/views/my_orders_view.dart';
import 'package:mocci/app/modules/previewScreen/bindings/preview_screen_binding.dart';
import 'package:mocci/app/modules/previewScreen/views/preview_screen_view.dart';
import 'package:mocci/app/modules/productDetail/bindings/product_detail_binding.dart';
import 'package:mocci/app/modules/productDetail/views/product_detail_view.dart';
import 'package:mocci/app/modules/profile/bindings/profile_binding.dart';
import 'package:mocci/app/modules/profile/views/profile_view.dart';
import 'package:mocci/app/modules/searchScreen/bindings/search_screen_binding.dart';
import 'package:mocci/app/modules/searchScreen/views/after_searchProduct.dart';
import 'package:mocci/app/modules/settings/bindings/settings_binding.dart';
import 'package:mocci/app/modules/settings/views/settings_view.dart';
import 'package:mocci/app/modules/shipping_Address/bindings/shipping_address_binding.dart';
import 'package:mocci/app/modules/shipping_Address/views/shipping_address_view.dart';
import 'package:mocci/app/modules/signup/bindings/signup_binding.dart';
import 'package:mocci/app/modules/signup/views/signup_view.dart';
import 'package:mocci/app/modules/walkthrough/bindings/walkthrough_binding.dart';
import 'package:mocci/app/modules/walkthrough/views/intro_screen.dart';
import 'package:mocci/app/modules/walkthrough/views/splashScreen.dart';
import 'package:mocci/app/modules/wishlist/bindings/wishlist_binding.dart';
import 'package:mocci/app/modules/wishlist/views/wishlist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WALKTHROUGH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      transition: Transition.native,
      transitionDuration: Duration(milliseconds: 500),
      page: () => HomeView(),
      popGesture: GetPlatform.isIOS ? true : false,
      preventDuplicates: true,
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WALKTHROUGH,
      page: () => SplashScreen(),
      popGesture: GetPlatform.isIOS ? true : false,
      preventDuplicates: true,
      binding: WalkthroughBinding(),
    ),
    // GetPage(
    //   name: _Paths.EXPLORE,
    //   page: () => ExploreView(),
    //   popGesture: GetPlatform.isIOS ? true : false,
    //   preventDuplicates: true,
    //   binding: ExploreBinding(),
    // ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => WishlistView(),
      popGesture: GetPlatform.isIOS ? true : false,
      preventDuplicates: true,
      binding: WishlistBinding(),
    ),
    GetPage(
      name: _Paths.MY_CART,
      page: () => MyCartView(),
      popGesture: GetPlatform.isIOS ? true : false,
      preventDuplicates: true,
      binding: MyCartBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      popGesture: GetPlatform.isIOS ? true : false,
      preventDuplicates: true,
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      transition: Transition.rightToLeft,
      popGesture: GetPlatform.isIOS ? true : false,
      preventDuplicates: true,
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      transition: Transition.rightToLeft,
      popGesture: GetPlatform.isIOS ? true : false,
      preventDuplicates: true,
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_SCREEN,
      page: () => AfterSearchProductsView(),
      popGesture: GetPlatform.isIOS ? true : false,
      preventDuplicates: true,
      binding: SearchScreenBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      transition: Transition.rightToLeft,
      popGesture: GetPlatform.isIOS ? true : false,
      binding: AccountBinding(),
      preventDuplicates: true,
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      transition: Transition.rightToLeft,
      popGesture: GetPlatform.isIOS ? true : false,
      preventDuplicates: true,
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASS,
      page: () => ForgotPassView(),
      binding: ForgotPassBinding(),
      preventDuplicates: true,
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: _Paths.CREDIT_CARD,
      page: () => CreditCardView(),
      binding: CreditCardBinding(),
    ),
    GetPage(
      name: _Paths.PREVIEW_SCREEN,
      page: () => PreviewScreenView(),
      binding: PreviewScreenBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDERS,
      page: () => MyOrdersView(),
      binding: MyOrdersBinding(),
    ),
    GetPage(
      name: _Paths.SHIPPING_ADDRESS,
      page: () => ShippingAddressView(),
      binding: ShippingAddressBinding(),
    ),
  ];
}
