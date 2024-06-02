import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GeoNanWidget extends StatefulWidget {
  const GeoNanWidget({Key? key}) : super(key: key);

  @override
  State<GeoNanWidget> createState() => _GeoNanWidgetState();
}

class _GeoNanWidgetState extends State<GeoNanWidget> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(
        'https://www.openstreetmap.org/?mlat=58.37824&mlon=26.75096#map=19/58.37824/26.75096'));

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 400, 
      width: double.infinity, 
      child: WebViewWidget(controller: controller),
    );
  }
}
