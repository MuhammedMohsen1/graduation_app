import 'package:application_gp/components/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Constants/constant.dart';
import '../../components/already_have_account.dart';
import '../../components/rounded_buttons.dart';
import '../../components/rounded_input.dart';

class Sign_Up_Screen extends StatefulWidget {
  Sign_Up_Screen({super.key});

  @override
  State<Sign_Up_Screen> createState() => _Sign_Up_ScreenState();
}

class _Sign_Up_ScreenState extends State<Sign_Up_Screen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                "assets/images/04.png",
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
                title: 'Sign up',
                function: () async {
                  if (validate(emailController.text, passwordController.text)) {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) => showToast('Signed up Successfully',
                            TOAST_STATUS.TOAST_SUCCESS))
                        .onError((error, stackTrace) =>
                            showToast('Failed', TOAST_STATUS.TOAST_FAILED));
                    setState(() {
                      emailController.text = '';
                      passwordController.text = '';
                    });
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              AlreadyHaveAccount(size: size, login: false),
            ],
          ),
        ),
      ),
    );
  }
}
