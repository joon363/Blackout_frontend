import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


class LocalHtmlPage extends StatefulWidget {
  @override
  _LocalHtmlPageState createState() => _LocalHtmlPageState();
}

class _LocalHtmlPageState extends State<LocalHtmlPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.loadFlutterAsset('assets/htmls/service_area_analysis.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LocalHtmlPage(),
  ));
}
