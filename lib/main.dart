import 'package:application_gp/components/position.dart';
import 'package:application_gp/layout/dashboard_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'modules/Customer/Customer_Dashboard.dart';
import 'modules/welcome_screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetPosition(true);

  SharedPreferences pref = await SharedPreferences.getInstance();
  bool? isLogin = pref.getBool('isLogin');
  bool? isEmployee = pref.getBool('isEmployee');
  print('isLogin is $isLogin');
  print('isEmployee is $isEmployee');
  if (isEmployee == null || isLogin == null) {
    isEmployee = false;
    isLogin = false;
  }
  runApp(MyApp(
    isLogin: isLogin,
    isEmployee: isEmployee,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLogin, required this.isEmployee});
  final bool isLogin;
  final bool isEmployee;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Widget widget;
    if (isLogin) {
      if (isEmployee) {
        widget = const DashboardLayout();
      } else {
        widget = const Customer_Dashboard();
      }
    } else {
      widget = const WelcomeScreen();
    }
    return MaterialApp(
      title: 'AWSQM',
      debugShowCheckedModeBanner: false,
      home: widget,
    );
  }
}
