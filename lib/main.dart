import 'package:application_gp/components/position.dart';
import 'package:application_gp/layout/dashboard_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/sharedPreference.dart';
import 'modules/Customer/Customer_Dashboard.dart';
import 'modules/welcome_screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetPosition();
  Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isLogin = pref.getBool('isLogin') as bool;
  runApp(MyApp(
    isLogin: isLogin,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.isLogin});
  final isLogin;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'AWSQM',
      debugShowCheckedModeBanner: false,
      home: isLogin ? const Customer_Dashboard() : const WelcomeScreen(),
    );
  }
}
