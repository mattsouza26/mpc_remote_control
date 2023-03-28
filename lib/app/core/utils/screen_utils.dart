import 'package:flutter/material.dart';

class ScreenUtils {
  double appBarHeight() {
    return AppBar().preferredSize.height;
  }

  double appBarAndStatusBarHeight(BuildContext context) {
    return AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
  }

  double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  double navigationBarHeight() {
    return WidgetsBinding.instance.window.padding.bottom;
  }

  Size screenSize(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Size(width, (height - appBarHeight()));
  }
}
