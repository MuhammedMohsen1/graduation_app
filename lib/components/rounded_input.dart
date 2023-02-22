import 'package:flutter/material.dart';

import '../Constants/constant.dart';

class RoundedInput extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final Size size;
  bool? isPassword;
  final Function onchanged;
  TextEditingController controller;
  RoundedInput({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.size,
    required this.onchanged,
    this.isPassword = false,
    required this.controller,
  });

  @override
  State<RoundedInput> createState() => _RoundedInputState(hintText, controller);
}

class _RoundedInputState extends State<RoundedInput> {
  bool isVisible = false;
  final String hintText;
  final TextEditingController controller;
  _RoundedInputState(this.hintText, this.controller);
  @override
  Widget build(BuildContext context) {
    return widget.isPassword!
        ? Container(
            height: widget.size.height * .075,
            width: widget.size.width * 0.75,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  widget.onchanged(value);
                },
                style: const TextStyle(
                  color: textColor,
                ),
                cursorColor: textColor,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  icon: Icon(
                    widget.prefixIcon,
                    size: 20,
                  ),
                  iconColor: textColor,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  suffixIcon: IconButton(
                      icon: !isVisible
                          ? const Icon(
                              Icons.visibility,
                            )
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      padding: const EdgeInsets.all(0)),
                  suffixIconColor: textColor,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w300,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        : Container(
            height: widget.size.height * .075,
            width: widget.size.width * 0.75,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  widget.onchanged(value);
                },
                style: const TextStyle(
                  color: textColor,
                ),
                cursorColor: textColor,
                decoration: InputDecoration(
                  icon: Icon(
                    widget.prefixIcon,
                    size: 20,
                  ),
                  iconColor: textColor,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                      color: textColor, fontWeight: FontWeight.w300),
                  border: InputBorder.none,
                ),
              ),
            ),
          );
  }
}
