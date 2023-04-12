import 'package:application_gp/Models/testData.dart';
import 'package:application_gp/components/view_more_button.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../Constants/constant.dart';
import '../modules/view_details/view_details.dart';
import 'package:intl/intl.dart' as intl;

class RecordItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final Size size;
  late final testData test;

  RecordItem({
    super.key,
    required this.size,
    required this.data,
  }) {
    test = testData(
      TDS: data['tds'],
      Temperature: data['temperature'],
      errorCode: 0,
      gps_lat: data['gpsLat'],
      gps_long: data['gpsLong'],
      modelName: data['name'],
      pH: data['ph'],
      status: 3,
      turbidity: data['turbidity'],
    );
  }

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
                          data['name'],
                          overflow: TextOverflow.clip,
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
                          intl.DateFormat('yyyy-MM-dd').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  data['time'])),
                          overflow: TextOverflow.clip,
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
                            color: data['polluted'] == 1
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
                        child: data['polluted'] == 1
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Drinkable water',
                                    overflow: TextOverflow.clip,
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
                                    overflow: TextOverflow.clip,
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
                    title: "more details",
                    screen: ViewDetails(
                      gps: LatLng(data['gpsLat'], data['gpsLong']),
                      test: test,
                      time: DateTime.fromMillisecondsSinceEpoch(data['time']),
                    ),
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
