import 'package:crypto_app/app/pages/auth/auth_page.dart';
import 'package:crypto_app/app/pages/home/home_page.dart';
import 'package:crypto_app/app/router/custom_router.dart';
import 'package:crypto_app/data/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        validateSession();
      });
    });
    super.initState();
  }

  validateSession() {
    final hasSession = firebaseAuthService.hasSession();
    if (hasSession) {
      customRouter.pushAndRemoveUntil(const HomePage());
    } else {
      customRouter.pushAndRemoveUntil(const AuthPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          color: Colors.black87,
        ),
        Center(
          child: Text("Crypto App",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white
            ),
          ),
        ),
        const Align(
          alignment: Alignment(0.0, 0.5),
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}