import 'package:application_gp/Constants/constant.dart';
import 'package:application_gp/components/navigator.dart';
import 'package:application_gp/modules/Payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubscriptionScreen extends StatefulWidget {
  SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isChangingPlan = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: background, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Account Settings',
                    style: TextStyle(
                      color: textColor,
                      fontSize: size.height * 0.025,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your Subscription is Active',
                    style: TextStyle(
                      color: textColor,
                      fontSize: size.height * 0.017,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Package: Basic',
                    style: TextStyle(
                      color: textColor,
                      fontSize: size.height * 0.017,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Plan: Monthly',
                    style: TextStyle(
                      color: textColor,
                      fontSize: size.height * 0.017,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 1.0),
                  child: Text(
                    'Price: 199.99 LE',
                    style: TextStyle(
                      color: textColor,
                      fontSize: size.height * 0.017,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your next Payment: 2/4/2023',
                    style: TextStyle(
                      color: textColor,
                      fontSize: size.height * 0.015,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: ElevatedButton(
            onPressed: () {
              navigateTo(context, Payment(price: 199.99));
            },
            style: ButtonStyle(
              animationDuration: Duration(milliseconds: 600),
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => background),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'Renew',
                  style: TextStyle(
                    color: textColor,
                    fontSize: size.height * 0.018,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isChangingPlan = !isChangingPlan;
              });
            },
            style: ButtonStyle(
              animationDuration: Duration(milliseconds: 600),
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => background),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  isChangingPlan ? 'Cancel' : 'Change The plan',
                  style: TextStyle(
                    color: textColor,
                    fontSize: size.height * 0.018,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: isChangingPlan ? 1 : 0,
          duration: const Duration(milliseconds: 600),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: background,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Package Name: VIB',
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Plan: Monthly',
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 1.0),
                    child: Text(
                      'Price: 449.99 LE',
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Description:',
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6.0, right: 2.0, bottom: 6.0),
                    child: Text(
                      'you can order 10 tests per month at specific location with precise monitoring',
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.016,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: isChangingPlan ? 1 : 0,
          duration: const Duration(milliseconds: 600),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: background,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Package Name: VIB PLUS',
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Plan: Monthly',
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 1.0),
                    child: Text(
                      'Price: 999.99 LE',
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Description:',
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6.0, right: 2.0, bottom: 6.0),
                    child: Text(
                      'you can order 20 continues-tests per month at specific location with precise monitoring',
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.height * 0.016,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height / 12,
        ),
      ],
    );
  }
}
