import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Privacy Policy',
            style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: WebView(
            initialUrl: 'about:blank',
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              _loadHtmlFromAssets();
            },
          ),
        ));
  }

  _loadHtmlFromAssets() async {
    String fileText =
        await rootBundle.loadString('assets/images/PrivacyPolicy.html');
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
