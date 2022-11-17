import 'package:flutter/material.dart';

class _CustomRouter {
  GlobalKey<NavigatorState> globalKey = GlobalKey();

  Future<T?> push<T>(Widget page) {
    return Navigator.push<T>(
      globalKey.currentContext!,
      PageRouteBuilder(pageBuilder: (c, a1, a2) => page),
    );
  }

  pushReplacement(Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        globalKey.currentContext!,
        PageRouteBuilder(pageBuilder: (c, a1, a2) => page),
      );
    });
  }

  pushAndRemoveUntil(Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(globalKey.currentContext!).pushAndRemoveUntil(
        PageRouteBuilder(pageBuilder: (c, a1, a2) => page),
        (Route<dynamic> route) => false,
      );
    });
  }

  pop({dynamic value}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(globalKey.currentContext!, value);
    });
  }

}

final customRouter = _CustomRouter();
