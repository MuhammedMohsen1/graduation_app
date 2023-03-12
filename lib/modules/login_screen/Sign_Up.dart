import 'dart:ui';

import 'package:application_gp/components/functions.dart';
import 'package:application_gp/components/navigator.dart';
import 'package:application_gp/layout/dashboard_layout.dart';
import 'package:application_gp/modules/Customer/Customer_Dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';

import '../../Constants/constant.dart';
import '../../components/already_have_account.dart';
import '../../components/rounded_buttons.dart';
import '../../components/rounded_input.dart';

class Sign_Up_Screen extends StatefulWidget {
  Sign_Up_Screen({super.key, required this.isEmployee});
  final bool isEmployee;
  @override
  State<Sign_Up_Screen> createState() => _Sign_Up_ScreenState(isEmployee);
}

class _Sign_Up_ScreenState extends State<Sign_Up_Screen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final bool isEmployee;
  bool isLoading = false;
  _Sign_Up_ScreenState(this.isEmployee);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: isEmployee
          ? AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: textColor,
                  size: 30,
                ),
                onPressed: () {
                  navigateBack(context);
                },
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            )
          : null,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: isEmployee
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    "assets/images/04.png",
                    width: size.width * .9,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RoundedInput(
                    controller: emailController,
                    hintText: isEmployee ? 'Employee Email' : 'Your Email',
                    prefixIcon: Icons.person_2_rounded,
                    size: size,
                    onchanged: (value) {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundedInput(
                    controller: passwordController,
                    hintText:
                        isEmployee ? 'Employee Password' : 'Your Password',
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
                      setState(() {
                        isLoading = true;
                      });
                      if (validate(
                          emailController.text, passwordController.text)) {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then(
                          (value) {
                            FirebaseFirestore.instance
                                .collection('users_role')
                                .doc(emailController.text)
                                .set({
                              'role': isEmployee ? 'Employee' : 'Customer',
                            }).then((value) {
                              showToast('Signed up Successfully',
                                  TOAST_STATUS.TOAST_SUCCESS);
                              navigateToAndReplace(
                                  context,
                                  isEmployee
                                      ? const DashboardLayout()
                                      : const Customer_Dashboard());
                            });
                          },
                        ).onError(
                          (error, stackTrace) {
                            showToast('Failed', TOAST_STATUS.TOAST_FAILED);
                          },
                        );
                        setState(() {
                          emailController.text = '';
                          passwordController.text = '';
                        });
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  isEmployee
                      ? const SizedBox()
                      : AlreadyHaveAccount(size: size, login: false),
                ],
              ),
            ),
          ),
          if (isLoading) ...[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: const CircularProgressIndicator(
                color: textColor,
              ),
            )
          ]
        ],
      ),
    );
  }
}
