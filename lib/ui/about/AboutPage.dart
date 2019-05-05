import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class AboutPage extends StatefulWidget {
  final String url;
  const AboutPage({Key key, this.url}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AboutPageState();


}

class AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: WebviewScaffold(
        url: widget.url,
        appBar: AppBar(
          title: Text("关于"),
          elevation: 0.4,
        ),
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,
      ),

    );
  }
}
