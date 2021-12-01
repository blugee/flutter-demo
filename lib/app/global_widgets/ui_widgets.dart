import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:double_back_to_close/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/modules/login/controllers/login_controller.dart';

/// MAIN BUTTONS
class MainButton extends StatelessWidget {
  MainButton({
    this.title,
    this.onPress,
    this.buttonColor,
  });

  final String title;
  final VoidCallback onPress;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints.tightFor(width: Get.width, height: Get.width / 7),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          primary: buttonColor,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
      ),
    );
  }
}

Text appBarTitle(String t) {
  return Text(
    t,
    style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
  );
}

/// CUSTOM INPUT FIELDS
Widget buildInputField({
  textController,
  title,
  isIcon,
  FormFieldValidator<String> validator,
}) =>
    Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
      child: TextFormField(
          textCapitalization: TextCapitalization.none,
          controller: textController,
          obscureText:
              isIcon ? LoginController.to.passwordVisibility.value : false,
          decoration: InputDecoration(
              labelText: title,
              labelStyle: kTextStyle.f16w5.copyWith(color: kColors.DARK_GREY),
              suffixIcon: isIcon
                  ? InkWell(
                      onTap: () =>
                          LoginController.to.passwordVisibility.toggle(),
                      child: Icon(
                        LoginController.to.passwordVisibility.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Color(0xFF757575),
                        size: 22,
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              contentPadding: EdgeInsets.only(top: 5)),
          style: kTextStyle.f16w5.copyWith(
            color: kColors.DARK_BLUE,
          ),
          textAlign: TextAlign.start,
          maxLines: 1,
          obscuringCharacter: "*",
          cursorColor: kColors.ERROR_YELLOW,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          validator: validator),
    );

/// CUSTOM AVATAR
class CustomCircleWidget extends StatelessWidget {
  CustomCircleWidget(
    this.baseSize,
    this.upperSize,
  );
  final double baseSize, upperSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kColors.DARK_GREY,
      radius: baseSize,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        width: upperSize.r,
        height: upperSize.r,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child:
              customCacheNetwokImage('https://picsum.photos/seed/710/600', 20),
        ),

        // _p.isFileSelected.value
        //     ? Image.file(
        //         File(_p.selectedImagePath.value),
        //         fit: BoxFit.cover,
        //       )
        //     : accDetailStorage.read("profilePic") != null
        //         ? Image.network(
        //             "${kApiTexts.PROFILE_PIC_BASE_URL}${accDetailStorage.read("profilePic")}")
        //         : Icon(
        //             Icons.person_rounded,
        //             color: Colors.white,
        //           ),
      ),
    );
  }
}

ListTile listTileForProfile(_title, _icon, _onTap) {
  return ListTile(
    minLeadingWidth: 30,
    minVerticalPadding: 10,
    onTap: _onTap,
    tileColor: Colors.white,
    dense: true,
    title: Text(
      _title,
      style: kTextStyle.f16w5.copyWith(color: kColors.DARK_BLUE),
    ),
    leading: SvgPicture.asset(
      (_icon),
      color: kColors.DARK_BLUE,
    ),
    trailing: Icon(
      Icons.navigate_next,
      color: kColors.DARK_BLUE,
    ),
    subtitle: Divider(),
  );
}

ListTile listTileForDrawer(_title, _icon, _onTap) {
  return ListTile(
    onTap: _onTap,
    tileColor: Colors.white,
    title: Text(
      _title,
      style: kTextStyle.f16w5.copyWith(color: kColors.DARK_BLUE),
    ),
    leading: SvgPicture.asset(
      (_icon),
      color: kColors.DARK_BLUE,
    ),
  );
}

void errorSnackbar(String msg) {
  return Get.rawSnackbar(
    message: '$msg',
    borderRadius: 10,
    margin: EdgeInsets.all(kDynamicWidth.width16),
    isDismissible: true,
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    duration: Duration(seconds: 4),
    icon: Icon(
      Icons.dangerous,
      color: Colors.white,
    ),
    shouldIconPulse: true,
    mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          "Dismiss",
          style: TextStyle(color: Colors.white),
        )),
    snackPosition: SnackPosition.TOP,
    backgroundColor: kColors.ERROR_YELLOW,
  );
}
