import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LogForm extends StatefulWidget {
  final void Function(String email, String password) onChangeControllers;

  const LogForm({
    Key? key,
    required this.onChangeControllers
  }) : super(key: key);

  @override
  State<LogForm> createState() => _SignInState();
}

class _SignInState extends State<LogForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool hidePassword;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    hidePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "Email",
          ),
          onChanged: (value) {
            widget.onChangeControllers(
              emailController.text,
              passwordController.text
            );
          },
        ),
        SizedBox(height: 5.h),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => hidePassword = !hidePassword);
              },
              icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
            )
          ),
          obscureText: hidePassword,
          onChanged: (value) {
            widget.onChangeControllers(
              emailController.text,
              passwordController.text
            );
          },
        ),
      ],
    );
  }

}