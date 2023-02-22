import 'package:flutter/material.dart';

import '../Constants/constant.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    super.key,
    required this.size,
    required this.title,
    required this.color,
    required this.function,
    this.width = 1,
    this.height = 1,
  });

  final Size size;
  final String title;
  final Color color;
  final Function function;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != 1 ? width : size.width * 0.75,
      height: height != 1 ? height : size.height * .075,
      child: ElevatedButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          function();
        },
        child: Text(
          title,
          style: TextStyle(
              fontSize: size.height * 0.025,
              letterSpacing: 1.7,
              color: textColor,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
