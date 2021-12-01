import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:mocci/app/data/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUse extends StatefulWidget {
  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Terms of use',
            style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
          ),
        ),
        body: WebView(
          initialUrl: 'about:blank',
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
            _loadHtmlFromAssets();
          },
        ));
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/images/toc.html');
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
