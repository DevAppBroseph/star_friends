import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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

  InAppWebViewController? _webViewController;
  
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
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse('https://star-friends.com')),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                ),
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
                FlutterNativeSplash.remove();
              },
            ),
          ),
        ),
      ),
    );
  }
}
