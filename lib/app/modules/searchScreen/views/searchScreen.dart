import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/modules/searchScreen/controllers/search_screen_controller.dart';
import 'package:mocci/app/routes/app_pages.dart';

import 'customDelegate.dart';

class SearchScreen extends StatelessWidget {
  final _s = Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Search',
          style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
                onPressed: () async {
                  var result = await showSearch<String>(
                    context: context,
                    delegate: CustomDelegate(hintText: 'Search for anything'),
                  );
                  _s.searchResult.value = result;
                },
                icon: Icon(Icons.search)),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: kDynamicWidth.width10),
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Obx(
              () => ListView(
                shrinkWrap: false,
                padding: EdgeInsets.all(kDynamicWidth.width20),
                children: [
                  GetUtils.isNullOrBlank(_s.searchResult.value)
                      ? Text(
                          'No search History',
                          style: kTextStyle.f16w5,
                          textAlign: TextAlign.center,
                        )
                      : Row(
                          children: [
                            Text(
                              'Recently Viewed',
                              style: kTextStyle.f14w4
                                  .copyWith(color: kColors.DARK_GREY),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                _s.searchResult.value = '';
                              },
                              child: Icon(
                                Icons.clear,
                                color: kColors.DARK_GREY,
                              ),
                            )
                          ],
                        ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  GetUtils.isNullOrBlank(_s.searchResult.value)
                      ? SizedBox()
                      : recentSearchItem(context, constraints)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget recentSearchItem(BuildContext context, constraints) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.SEARCH_SCREEN, arguments: _s.searchResult.value),
      child: Container(
        /// base container
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.17,
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(1, 0),
              child: Material(
                /// for elevation effect on container
                color: Colors.transparent,
                shadowColor: Color(0xFF919EAB).withOpacity(0.4),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  ///show detail container
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: EdgeInsets.only(left: 70, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _s.searchResult.value.capitalizeFirst,
                              style: kTextStyle.f18w6.copyWith(
                                  fontSize: 14, color: kColors.ERROR_YELLOW),
                            ),
                            GestureDetector(
                              onTap: () {
                                _s.isFav.toggle();
                              },
                              child: CustomAnimatedFavButton(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: kColors.DARK_BLUE,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(4),
                        child: Text('\$50.00',
                            style:
                                kTextStyle.f13w5.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.95, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/seed/572/600',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, string) => Center(
                      child: CircularProgressIndicator(
                    backgroundColor: kColors.ERROR_YELLOW,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedCrossFade CustomAnimatedFavButton() {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 400),
      firstChild: Icon(
        Icons.favorite_border,
        color: kColors.PINKIESH,
      ),
      secondChild: Icon(
        Icons.favorite_rounded,
        color: kColors.PINKIESH,
      ),
      crossFadeState:
          _s.isFav.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
