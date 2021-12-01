import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/data/utils/cardUtils.dart';
import 'package:mocci/app/data/utils/utils.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import '../controllers/credit_card_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditCardView extends GetView<CreditCardController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        key: controller.cardScaffoldKey,
        appBar: AppBar(
          title: appBarTitle('Checkout'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(kDynamicWidth.width20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [appBarTitle('Select Payment Method'), _buildTabBar()],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildTabBar() {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              isScrollable: true,
              labelColor: kColors.DARK_BLUE,
              unselectedLabelColor: Color(0x8E928787),
              labelPadding: EdgeInsets.symmetric(
                horizontal: 40.w,
              ),
              indicatorColor: kColors.DARK_BLUE,
              indicatorWeight: 3,
              tabs: [
                Tab(
                  icon: FaIcon(
                    FontAwesomeIcons.solidCreditCard,
                    size: 25,
                  ),
                ),
                Tab(
                  icon: FaIcon(
                    FontAwesomeIcons.ccPaypal,
                    size: 25,
                  ),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: PageScrollPhysics(),
                children: [cardWidget(), Text('')],
              ),
            ),
          ],
        ),
      ),
    );
  }

  cardWidget() {
    return Container(
      height: Get.height,
      width: Get.width,
      padding: EdgeInsets.only(top: kDynamicWidth.width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Credit card details',
            style: kTextStyle.f16w5.copyWith(color: kColors.DARK_BLUE),
          ),
          SizedBox(height: 10.h),
          // Obx(
          //   () => Container(
          //     width: Get.width,
          //     child: CreditCardWidget(
          //       cardNumber: controller.cardNumber.value,
          //       expiryDate: controller.expiryDate.value,
          //       cardHolderName: controller.cardHolderName.value,
          //       cvvCode: controller.cvvCode.value,
          //       showBackView: controller.isCvvFocused.value,
          //       cardBgColor: Colors.black54,
          //       obscureCardNumber: true,
          //       obscureCardCvv: true,
          //       animationDuration: const Duration(milliseconds: 800),
          //       // cardType:,
          //     ),
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                return CreditCardForm(
                  formKey: controller.cardFormKey,
                  obscureCvv: true,
                  obscureNumber: false,
                  cardNumber: controller.cardNumber.value,
                  expiryDate: controller.expiryDate.value,
                  cardHolderName: controller.cardHolderName.value,
                  cvvCode: controller.cvvCode.value,
                  themeColor: kColors.DARK_BLUE,
                  textColor: kColors.DARK_BLUE,
                  cvvValidationMessage: 'Invalid CVV',
                  cardNumberDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: getCardTypeIcon(controller.cardNumber.value),
                    ),
                    labelText: 'Card Number',
                    labelStyle:
                        kTextStyle.f14w4.copyWith(color: kColors.ERROR_YELLOW),
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle:
                        kTextStyle.f14w4.copyWith(color: kColors.ERROR_YELLOW),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Expired Date',
                    hintText: 'XX/XX',
                  ),
                  cvvCodeDecoration: InputDecoration(
                    labelStyle:
                        kTextStyle.f14w4.copyWith(color: kColors.ERROR_YELLOW),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle:
                        kTextStyle.f14w4.copyWith(color: kColors.ERROR_YELLOW),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Card Holder',
                  ),
                  onCreditCardModelChange: onCreditCardModelChange,
                );
              }),
            ),
          ),
          MainButton(
            onPress: () {
              if (controller.cardFormKey.currentState.validate()) {
                print('valid!');
              } else {
                print('invalid!');
              }
            },
            buttonColor: kColors.ERROR_YELLOW,
            title: 'Continue',
          )
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    controller.cardNumber.value = creditCardModel.cardNumber;
    controller.expiryDate.value = creditCardModel.expiryDate;
    controller.cardHolderName.value = creditCardModel.cardHolderName;
    controller.cvvCode.value = creditCardModel.cvvCode;
    controller.isCvvFocused.value = creditCardModel.isCvvFocused;
  }

  /// ===============================================================
//   TextFormField _textField(
//       {TextEditingController ctrller,
//       String title,
//       TextInputType type,
//       List<TextInputFormatter> inputFormat,
//       String Function(String) validation,
//       icon}) {
//     return TextFormField(
//       controller: ctrller,
//       textInputAction: TextInputAction.next,
//       validator: validation,
//       inputFormatters: inputFormat,
//       keyboardType: type,
//       decoration: InputDecoration(
//         suffixIcon: icon,
//         labelText: title,
//         counterText: '',
//         labelStyle: kTextStyle.f14w4.copyWith(color: kColors.ERROR_YELLOW),
//         contentPadding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
//         enabledBorder: OutlineInputBorder(),
//         disabledBorder: OutlineInputBorder(),
//         focusedBorder: OutlineInputBorder(),
//         errorBorder: OutlineInputBorder(),
//       ),
//     );
//   }
// }

}
