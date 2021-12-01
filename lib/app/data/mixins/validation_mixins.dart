import 'package:get/get_utils/src/get_utils/get_utils.dart';

class ValidationMixin {
  String validateReqFields(value) {
    if (GetUtils.isNullOrBlank(value)) {
      return '*Required Field';
    } else {
      return null;
    }
  }

  String validateEmail(value) {
    if (GetUtils.isNullOrBlank(value)) {
      return '*Required Field';
    } else if (!GetUtils.isEmail(value)) {
      return 'Incorrect email';
    } else {
      return null;
    }
  }

  static String validateCVV(String value) {
    if (value.isEmpty) {
      return 'Field is Required';
    }

    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }
}
