import 'package:crypto_app/app/pages/auth/widgets/custom_form.dart';
import 'package:crypto_app/app/pages/home/home_page.dart';
import 'package:crypto_app/app/router/custom_router.dart';
import 'package:crypto_app/app/utils/utils.dart';
import 'package:crypto_app/app/widgets/logo.dart';
import 'package:crypto_app/data/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late bool loadingButton;
  late bool isLogIn;
  late String email;
  late String password;

  @override
  void initState() {
    loadingButton = false;
    isLogIn = true;
    email = "";
    password = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 20.h),
              const Logo(),
              SizedBox(height: 5.h),
              LogForm(
                onChangeControllers: (emailController, passwordController) {
                  setState(() {
                    email = emailController;
                    password = passwordController;
                  });
                },
              ),
              SizedBox(height: 5.h),
              signMode(),
              SizedBox(height: 2.h),
              ElevatedButton(
                onPressed: () async {
                  setState(() => loadingButton = true);
                  if (isLogIn) {
                    await firebaseAuthService.signInEmail(email, password).catchError((error) {
                      setState(() => loadingButton = false);
                      utils.showSnackBar(context, error.toString(), SnackBarType.error);
                    }).then((value) {
                      if(value == true) {
                        customRouter.pushAndRemoveUntil(const HomePage());
                      }
                    });
                  } else {
                    await firebaseAuthService.signUpEmail(email, password).catchError((error) {
                      setState(() => loadingButton = false);
                      utils.showSnackBar(context, error.toString(), SnackBarType.error);
                    }).then((value) {
                      if(value == true) {
                        customRouter.pushAndRemoveUntil(const HomePage());
                      }
                    });
                  }
                },
                child: loadingButton ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ) :
                Text(isLogIn ? "Sign In" : "Sign Up")
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget signMode() {
    return isLogIn ? signWidget(
      "Don't have an account? ",
      "Sign Up",
      false
    ) : signWidget(
      "Already have an account? ",
      "Sign In",
      true
    );
  }

  Widget signWidget(String textDescription, String mainText, bool value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(textDescription),
        GestureDetector(
          onTap: () {
            setState(() => isLogIn = value);
          },
          child: Text(mainText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.blueAccent
            ),
          )
        )
      ],
    );
  }

}