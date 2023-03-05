import 'package:application_gp/Constants/constant.dart';
import 'package:application_gp/components/navigator.dart';
import 'package:application_gp/modules/Payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShipScreen extends StatelessWidget {
  const ShipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Image.asset('assets/images/sailboat7.PNG'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Model: MOHSEN',
                    style: TextStyle(
                      color: textColor,
                      letterSpacing: 1.5,
                      fontSize: size.height * 0.017,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'ID: 1V10001',
                    style: TextStyle(
                      color: textColor,
                      letterSpacing: 1.5,
                      fontSize: size.height * 0.017,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Version 1.0.1',
                    style: TextStyle(
                      color: textColor,
                      letterSpacing: 1.5,
                      fontSize: size.height * 0.017,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Battery: 3hr',
                    style: TextStyle(
                      color: textColor,
                      letterSpacing: 1.5,
                      fontSize: size.height * 0.017,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Price: 8999.99 LE',
                    style: TextStyle(
                      color: textColor,
                      letterSpacing: 1.5,
                      fontSize: size.height * 0.017,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: ElevatedButton(
            onPressed: () {
              navigateTo(
                  context,
                  Payment(
                    price: 8999.99,
                  ));
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
                  'Buy Now',
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
      ],
    );
  }
}
