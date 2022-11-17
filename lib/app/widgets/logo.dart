import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final bool smallLogo;

  const Logo({
    Key? key,
    this.smallLogo = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Crypto App",
      style: getStyle(context)
    );
  }

  TextStyle? getStyle(BuildContext context) {
    if (smallLogo) {
      return Theme.of(context).textTheme.titleSmall;
    } else {
      return Theme.of(context).textTheme.displaySmall;
    }
  }

}