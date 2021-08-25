import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late WebViewController webViewController;
  var opecityValue = 1.0;
  bool load = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        load = true;
      });
    });
  }

  String url = 'https://m.movv.co';
  late TextEditingController textEditingController = TextEditingController()
    ..text = url;

  urlChange() {
    setState(() {
      webViewController.loadUrl(url);
      opecityValue = 1.0;
    });
  }

  opecity() {
    setState(() {
      opecityValue = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() async {
          var val = await webViewController.canGoBack();
          if (val)
            webViewController.goBack();
          else
            Get.back();
        });

        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: MaterialButton(
              onPressed: () {
                setState(() async {
                  var val = await webViewController.canGoBack();
                  if (val)
                    webViewController.goBack();
                  else
                    Get.back();
                });
              },
              minWidth: 0.0,
              padding: EdgeInsets.zero,
              child: Icon(Icons.arrow_back)),
          title: TextField(
            onSubmitted: (value) => urlChange(),
            onChanged: (value) => url = value,
            style: TextStyle(color: Colors.white),
            controller: textEditingController,
            cursorColor: Colors.white,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                onWebViewCreated: (controller) =>
                    webViewController = controller,
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (url) => opecity(),
              ),
              Opacity(
                  opacity: opecityValue,
                  child: Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }
}
