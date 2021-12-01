import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mocci/app/data/LocalStorage/localStorage.dart';
import 'package:mocci/app/data/Models/getProducts_Model.dart';
import 'package:mocci/app/data/Provider/provider.dart';
import 'package:mocci/app/modules/home/views/home_view.dart';
import 'package:mocci/app/modules/login/views/login_view.dart';
import 'package:mocci/app/modules/myCart/views/my_cart_view.dart';
import 'package:mocci/app/modules/profile/views/profile_view.dart';
import 'package:mocci/app/modules/wishlist/views/wishlist_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  RxInt caraousalIndex = 0.obs;
  static HomeController get to => Get.find<HomeController>();
  final refreshController = RefreshController(initialRefresh: false);

  RxInt currentIndex = 0.obs;
  RxBool isFav = false.obs;
  List<Widget> children =
      [ExploreView(), WishlistView(), MyCartView(), ProfileView()].obs;

  // String id;
  static const limit = 20;
  final pagingController = PagingController<int, MyProduct>(firstPageKey: 1);

  @override
  onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  onRefresh() async {
    _fetchPage(1);
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ApiProvider.getProductList(
        //    id,
        pageKey,
        limit,
      );
      print(newItems.length);
      final isLastPage = newItems.length < limit;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
