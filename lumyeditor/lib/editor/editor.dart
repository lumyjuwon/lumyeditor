import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:lumyeditor/editor/content/content.dart';
import 'package:lumyeditor/editor/content/selection_info.dart';
import 'package:lumyeditor/editor/toolbar/toolbar.dart';

enum Position { Top, Bottom }

class Editor extends StatefulWidget {
  final Position position;

  const Editor({this.position = Position.Top}) : super();

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  final ValueNotifier<SelectionInfo> selectionListener =
      new ValueNotifier(new SelectionInfo(''));
  WebViewController webviewController;

  void initController(WebViewController controller) {
    if (webviewController == null) {
      this.setState(() {
        webviewController = controller;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.position == Position.Top) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Content(
                selectionListener: this.selectionListener,
                initController: this.initController,
              ),
            ),
            Toolbar(
              position: widget.position,
              selectionListener: this.selectionListener,
              webviewController: this.webviewController,
            ),
          ],
        ),
      );
    } else if (widget.position == Position.Bottom) {
      return Scaffold(
          body: Column(
        children: <Widget>[
          Expanded(
            child: Content(
              selectionListener: this.selectionListener,
              initController: this.initController,
            ),
          ),
          Toolbar(
            position: widget.position,
            selectionListener: this.selectionListener,
            webviewController: this.webviewController,
          ),
        ],
      ));
    }
  }
}
