import 'dart:ui';

import 'package:application_gp/modules/login_screen/cubit/login_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Constants/constant.dart';
import '../../components/already_have_account.dart';

import '../../components/rounded_buttons.dart';
import '../../components/rounded_input.dart';

import 'Sign_Up.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<LoginCubit>(context);
          print(state);
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IgnorePointer(
                    ignoring: (state is LoginLoadingState) ? true : false,
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
                            controller: cubit.email,
                            hintText: 'Your Email',
                            prefixIcon: Icons.person_2_rounded,
                            size: size,
                            onchanged: (value) {},
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          RoundedInput(
                            controller: cubit.password,
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
                            function: () {
                              cubit.login_button(context);
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
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
                  if (state is LoginLoadingState) ...[
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        width: size.width,
                        height: size.height,
                        child: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
