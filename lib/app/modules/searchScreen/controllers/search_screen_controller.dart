import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';

class SearchScreenController extends GetxController {
  final searchField = TextEditingController();
  RxBool isFav = false.obs;
  RxBool isFilter = true.obs;
  RxString searchResult = ''.obs;


/// FILTER VARIABLES ============================///
  List<String> ringTag ;
  List<String> ringsOptions = [
    'Engagement',
    'Wedding',
    'Gemstone',
  ];
  List<String> braceletTag ;
  List<String> braceletOptions = [
    'Name',
    'Bangle',
    'Chain',
  ];
  List<String> earringTag ;
  List<String> earringsOptions = [
    'Hoops',
    'Stud',
  ];
  List<String> pendantsTag ;
  List<String> pendantsOptions = [
    'Name',
    'Letter',
    'Number',
    'Zodiac',
  ];

  /// SORT VARIABLES ==========================//
 RxInt sortingTag =0.obs;
List<String> sortingOptions = ['Popularity','What\'s new','Discount','Customer Rating'];

  @override
  void onClose() {
    searchField.dispose();
    super.onClose();
  }
}
