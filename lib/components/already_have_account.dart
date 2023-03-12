import 'package:application_gp/modules/login_screen/login.dart';
import 'package:flutter/material.dart';

import '../Constants/constant.dart';
import '../modules/login_screen/Sign_Up.dart';
import 'navigator.dart';

class AlreadyHaveAccount extends StatelessWidget {
  bool login;
  AlreadyHaveAccount({
    super.key,
    required this.size,
    this.login = true,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          !login ? "Already have an account ?" : "Don't have an account ?",
          style: TextStyle(
            color: textColor,
            fontSize: size.height * 0.015,
          ),
        ),
        InkWell(
          onTap: () {
            login
                ? navigateTo(
                    context,
                    Sign_Up_Screen(
                      isEmployee: false,
                    ))
                : navigateTo(context, LoginScreen());
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(login ? 'Sign Up' : 'Sign in',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: size.height * 0.015,
                )),
          ),
        ),
      ],
    );
  }
}
