import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class kColors {
  static const Color DARK_BLUE = Color(0xFF273751);
  static const Color PINKIESH = Color(0xFFB78389);
  static const Color ERROR_YELLOW = Color(0xFFCFA32B);
  static const Color GREY1 = Color(0xFFFFF8E6);
  static const Color GREY_2 = Color(0xFFF2F2F2);
  static const Color DARK_GREY = Color(0xFFAAAAAA);
  static const Color BG = Color(0xFFD6D6D6);
  static const Color DARKEST_NAVY = Color(0xFF273677);
  static const Color SILVER = Color(0xffC0C0C0);
  static const Color GOLD = Color(0xffFFD700);
  static const Color DIAMOND = Color(0xfff8f4ec);
  static Color SHADOW_COLOR = Color(0xFF919EAB).withOpacity(0.3);
}

class kTextStyle {
  static TextStyle f20w5 =
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500);
  static TextStyle f13w5 =
      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500);
  static TextStyle f12w4 =
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);
  static TextStyle f14w4 =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400);
  static TextStyle f16w5 =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);
  static TextStyle f18w6 =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600);
}

class kDynamicWidth {
  static double width20 = Get.width / 17;
  static double width16 = Get.width / 25;
  static double width10 = Get.width / 40;
  static double width50 = Get.width / 9;
}

class Strings {
  static const String appName = 'Payment Card Demo';
  static const String fieldReq = 'This field is required';
  static const String numberIsInvalid = 'Card is invalid';
  static const String pay = 'Validate';
}

// 'http://192.168.1.3:4000/'
class kApiTexts {
  static const BASE_URL = 'http://143.198.174.34:4000/';
  static const LOGIN = 'v1/auth/login';
  static const SIGNUP = 'v1/auth/registration';
  static const GET_PRODUCT_LIST = 'v1/user/all-product';
}

class ShapeWayApi {
  static const BASE_URL = 'https://api.shapeways.com/';
  static const ACCESS_TOKEN = 'oauth2/token';
  static const GET_SHAPEWAY_MATERIALS = 'materials/v1';
  static const UPLOAD_MODEL = '/models/v1';
  static const CLIENT_ID = 'fWftF4els87AJV0FIRjiHkyOaIWoSxRET02vEkfV20E1lbKmmN';
  static const CLIENT_SECRET =
      'ET0jAAOPbuQMKC8IOYdQAHNrZZwRo6NzjbpWRnyHiuJERf08uW';
}
