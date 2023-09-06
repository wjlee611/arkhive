import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _webviewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..loadRequest(Uri.parse('https://github.com/wjlee611/arkhive/releases'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppFont(
          '패치노트',
          color: Colors.white,
          fontSize: Sizes.size16,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: WebViewWidget(
        controller: _webviewController,
      ),
    );
  }
}
