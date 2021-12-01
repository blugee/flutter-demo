import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocci/app/data/LocalStorage/localStorage.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/account/controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  final localStorage = LocalStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(kDynamicWidth.width20),
        children: [
          Center(
            child: CustomCircleAvatar(
              () {
                buildBottomSheet();
              },
            ),
          ),
          SizedBox(
            height: kDynamicWidth.width20,
          ),
          CustomColumn(
            subfield: localStorage.FIRST_NAME() ?? '',
            heading: "First Name",
            isButton: false,
          ),
          CustomColumn(
            subfield: localStorage.LAST_NAME() ?? '',
            heading: "Last Name",
            isButton: false,
          ),
          CustomColumn(
            subfield: '@hemant',
            heading: "username",
            isButton: false,
          ),
          CustomColumn(
            subfield: localStorage.EMAIL() ?? '',
            heading: "Email",
            isButton: true,
            buttonIcon: Icons.email_outlined,
            onPress: () {},
          ),
          CustomColumn(
            subfield: "405 N. Madison Ave #4",
            heading: "address",
            isButton: true,
            buttonIcon: Icons.location_city_outlined,
            onPress: () {},
          ),
          CustomColumn(
            subfield: "Mar 18, 1991",
            heading: "Date of birth",
            isButton: false,
          ),
          CustomColumn(
            subfield: "+123456789",
            heading: "phone",
            isButton: true,
            buttonIcon: Icons.phone_enabled_outlined,
            onPress: () {},
          ),
          CustomColumn(
            subfield:
                """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.""",
            heading: "about",
            isButton: false,
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildBottomSheet() {
    return Get.bottomSheet(
        Container(
          padding: EdgeInsets.all(kDynamicWidth.width20),
          height: Get.height / 5,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Choose Profile',
                style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
              ),
              SizedBox(
                height: kDynamicWidth.width10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomListTile("Gallery", () async {
                    await controller.getImageFromGallery(ImageSource.gallery);
                    Get.back();
                  }, Icons.perm_media_outlined),
                  CustomListTile("Camera", () async {
                    await controller.getImageFromGallery(ImageSource.camera);
                    Get.back();
                  }, Icons.camera_alt_outlined),
                  CustomListTile("Remove", () async {
                    await controller.clearImage();
                  }, Icons.delete_forever_outlined),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))));
  }
}

Widget CustomListTile(_text, _onPress, icon) {
  return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    Icon(
      icon,
      color: kColors.ERROR_YELLOW,
    ),
    Text(
      _text,
      style: kTextStyle.f14w4.copyWith(color: kColors.DARK_BLUE),
    ),
  ]);
}

Widget CustomCircleAvatar(Function onTap) {
  return Stack(
    children: [
      Center(
          child: CustomCircleWidget(
        Get.width / 6,
        Get.width / 3.3,
      )),
      Positioned(
        right: Get.width / 3.5,
        bottom: 10,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
              width: 32,
              height: 32,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kColors.DARK_BLUE,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 2, offset: Offset(2, 3))
                  ]),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 17,
              )),
        ),
      )
    ],
  );
}

class CustomColumn extends StatelessWidget {
  CustomColumn(
      {Key key,
      this.buttonIcon,
      this.heading,
      this.onPress,
      this.subfield,
      @required this.isButton})
      : super(key: key);

  final String heading, subfield;
  final IconData buttonIcon;
  final Function onPress;
  final bool isButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDynamicWidth.width10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                heading.capitalizeFirst,
                style: kTextStyle.f14w4.copyWith(color: kColors.DARK_GREY),
              ),
              isButton
                  ? GestureDetector(
                      onTap: onPress,
                      child: Icon(
                        buttonIcon,
                        color: kColors.ERROR_YELLOW,
                      ))
                  : SizedBox()
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subfield,
            style: kTextStyle.f16w5.copyWith(
                fontWeight: FontWeight.w500, color: kColors.DARK_BLUE),
          ),
          Divider()
        ],
      ),
    );
  }
}
