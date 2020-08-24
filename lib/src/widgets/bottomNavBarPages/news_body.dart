import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: WebView(
          initialUrl:
              "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/news",
        ),
      ),
    );
  }
}
