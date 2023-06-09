import 'package:flutter/material.dart';

class ScreenUtils {
  double appBarHeight(BuildContext context) {
    return AppBar().preferredSize.height;
  }

  double appBarAndStatusBarHeight(BuildContext context) {
    return AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
  }

  double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  double navigationBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  Size screenSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Size(size.width, (size.height - appBarHeight(context)));
  }
}
