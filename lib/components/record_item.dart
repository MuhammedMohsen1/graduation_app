import 'package:application_gp/components/view_more_button.dart';
import 'package:flutter/material.dart';

import '../Constants/constant.dart';
import '../modules/view_more/view_more.dart';

class RecordItem extends StatelessWidget {
  const RecordItem({
    super.key,
    required this.size,
    required this.isClean,
  });

  final Size size;
  final bool isClean;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: Container(
        width: size.width,
        height: size.height / 12,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: textColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: textColor.withOpacity(0.2)),
              color: background.withOpacity(.09),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'ASWQM-1',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '22/2/2023',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w300,
                            fontSize: size.height * 0.017,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 1.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: isClean
                                ? textColor.withOpacity(0.6)
                                : Colors.redAccent),
                        color: background.withOpacity(.07),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8,
                        ),
                        child: isClean
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Drinkable water',
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.height * 0.011,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: textColor,
                                    size: size.height / 50,
                                  ),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Polluted water',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.height * 0.011,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Icon(
                                    Icons.close,
                                    color: textColor,
                                    size: size.height / 50,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  ViewMoreButton(
                    size: size,
                    /* add different screen*/
                    /* TODO: */
                    screen: const ViewMore(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
