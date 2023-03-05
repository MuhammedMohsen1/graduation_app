import 'package:application_gp/components/navigator.dart';
import 'package:application_gp/components/rounded_input.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../Constants/constant.dart';

class Payment extends StatelessWidget {
  Payment({super.key, required this.price});
  final double price;
  var idController = TextEditingController();
  var expDateController = TextEditingController();
  var cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(
          onPressed: () {
            navigateBack(context);
          },
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset('assets/images/payment.png'),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: textColor, width: 0.5),
                    color: background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${price.toString()} LE',
                      style: TextStyle(
                          color: textColor,
                          letterSpacing: 1.5,
                          shadows: const [
                            Shadow(
                              blurRadius: 2,
                              color: background,
                            ),
                          ],
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width / 1,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            child: TextField(
                              controller: idController,
                              cursorWidth: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: const Icon(
                                  LineIcons.creditCard,
                                  color: textColor,
                                ),
                                hintText: 'CreditCard ID',
                                hintStyle: TextStyle(
                                  color: textColor,
                                  fontSize: size.height * 0.015,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              cursorColor: textColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: background,
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: TextField(
                                    controller: expDateController,
                                    cursorWidth: 1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'EXP DATE',
                                      hintStyle: TextStyle(
                                        color: textColor,
                                        fontSize: size.height * 0.015,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    cursorColor: textColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: background,
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: TextField(
                                    controller: cvvController,
                                    cursorWidth: 1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'CVV',
                                      hintStyle: TextStyle(
                                        color: textColor,
                                        fontSize: size.height * 0.015,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    cursorColor: textColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            )),
                            animationDuration:
                                const Duration(milliseconds: 600),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => background),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(
                                'Pay',
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
