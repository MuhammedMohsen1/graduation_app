import 'package:app_settings/app_settings.dart';
import 'package:application_gp/components/rounded_buttons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/constant.dart';
import '../../components/sharedPreference.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              background,
              background.withOpacity(0.9),
              background.withOpacity(0.4),
              background.withOpacity(0.2),
              Colors.white,
              Colors.white,
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Bluetooth.png",
                width: size.width * .9,
              ),
              const SizedBox(
                height: 40,
              ),
              RoundedButton(
                  size: size,
                  title: 'Connect',
                  width: size.width / 2.5,
                  color: background_dark.withOpacity(0.8),
                  function: () async {
                    AppSettings.openBluetoothSettings();
                  }),
              const SizedBox(
                height: 40,
              ),
              Text(
                'To continue, you must connect to your robot',
                style: TextStyle(
                  color: textColor,
                  fontSize: size.height * 0.015,
                  letterSpacing: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
