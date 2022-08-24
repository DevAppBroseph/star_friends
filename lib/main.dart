import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  WebViewController? _webViewController;
  
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Star-Friends',
      home: WillPopScope(
        onWillPop: () async {
          if(_webViewController != null) {
            if (await _webViewController!.canGoBack()) {
              await _webViewController!.goBack();
              return false;
            }
          }
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: WebView(
              initialUrl: 'https://star-friends.com',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                FlutterNativeSplash.remove();
              },
            ),
          ),
        ),
      ),
    );
  }
}
