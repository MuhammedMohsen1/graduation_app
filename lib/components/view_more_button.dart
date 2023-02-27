import 'package:flutter/material.dart';

import '../Constants/constant.dart';
import '../modules/view_more/view_more.dart';
import 'navigator.dart';

class ViewMoreButton extends StatelessWidget {
  const ViewMoreButton(
      {super.key,
      required this.size,
      required this.screen,
      this.title = "view more"});
  final Widget screen;
  final String title;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ElevatedButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        style: ElevatedButton.styleFrom(
          backgroundColor: background_dark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          navigateTo(context, screen);
        },
        child: Text(
          title,
          style: TextStyle(
              fontSize: size.height * 0.013,
              letterSpacing: 1.7,
              color: textColor,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
