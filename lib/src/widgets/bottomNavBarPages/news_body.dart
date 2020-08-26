import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//TODO: implement back button
class NewsBody extends StatefulWidget {
  @override
  _NewsBodyState createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: WebView(
          initialUrl:
              "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/news",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
