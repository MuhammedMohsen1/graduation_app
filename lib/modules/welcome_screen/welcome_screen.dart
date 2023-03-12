import 'package:application_gp/Constants/constant.dart';
import 'package:application_gp/components/rounded_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:application_gp/modules/login_screen/Sign_Up.dart';
import 'package:application_gp/modules/login_screen/login.dart';
import 'package:flutter/material.dart';

import '../../components/navigator.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Column(
            children: [
              Image.asset(
                "assets/images/02.png",
                height: size.height * .65,
              ),

              /* || ROUNDED BUTTON  */
              RoundedButton(
                  color: primaryColor,
                  size: size,
                  title: 'Login',
                  function: () {
                    navigateTo(context, LoginScreen());
                  }),
              const SizedBox(
                height: 15,
              ),
              RoundedButton(
                  color: primaryColor.withAlpha(90),
                  size: size,
                  title: 'Sign up',
                  function: () {
                    navigateTo(context, Sign_Up_Screen(isEmployee: false));
                  }),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.copyright_outlined, size: 10),
                    Text(
                      'copyright Mohsen co',
                      style: TextStyle(
                        fontSize: 6,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
