import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///TOAST
showToast(context, message) {
  Toast.show(
    message,
    context,
    gravity: Toast.bottom,
  );
}

/// CUSTOM LOADER
Widget mocciLoader(double _size) => SpinKitFadingCube(
      color: kColors.ERROR_YELLOW,
      size: _size,
    );

/// HIDE KEYBOARD
void hideKeyboard(context) => FocusScope.of(context).unfocus();

///CUSTOM NTWK IMG
customCacheNetwokImage(image, double size) => CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
      placeholder: (BuildContext, String) => mocciLoader(size),
      errorWidget: (BuildContext, String, dynamic) =>
          Icon(Icons.error_outline_outlined),
    );
