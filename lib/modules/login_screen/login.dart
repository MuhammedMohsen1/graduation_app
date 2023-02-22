import 'package:application_gp/components/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Constants/constant.dart';
import '../../components/already_have_account.dart';
import '../../components/functions.dart';
import '../../components/rounded_buttons.dart';
import '../../components/rounded_input.dart';
import '../../layout/dashboard_layout.dart';
import 'Sign_Up.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/03_login.png",
                width: size.width * .9,
              ),
              RoundedInput(
                controller: emailController,
                hintText: 'Your Email',
                prefixIcon: Icons.person_2_rounded,
                size: size,
                onchanged: (value) {},
              ),
              const SizedBox(
                height: 15,
              ),
              RoundedInput(
                controller: passwordController,
                hintText: 'Your Password',
                prefixIcon: Icons.lock,
                size: size,
                isPassword: true,
                onchanged: (value) {},
              ),
              const SizedBox(
                height: 30,
              ),
              RoundedButton(
                color: primaryColor,
                size: size,
                title: 'Login',
                function: () async {
                  if (validate(emailController.text, passwordController.text)) {
                    await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      showToast('Login Success', TOAST_STATUS.TOAST_SUCCESS);
                      if (value.toString().isNotEmpty) {
                        navigateToAndReplace(context, const DashboardLayout());
                      }
                    }).onError((error, stackTrace) {
                      showToast('Failed', TOAST_STATUS.TOAST_FAILED);
                    });
                    setState(() {
                      emailController.clear();
                      passwordController.clear();
                    });
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              AlreadyHaveAccount(size: size, login: true),
            ],
          ),
        ),
      ),
    );
  }
}
