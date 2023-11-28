import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../Constants/constant.dart';
import '../../Models/testData.dart';

import '../../components/navigator.dart';
import '../../layout/dashboard_layout.dart';
import '../Customer/Customer_Dashboard.dart';

class ViewDetails extends StatelessWidget {
  const ViewDetails(
      {super.key, required this.test, required this.gps, required this.time});
  final testData test;
  final LatLng gps;
  final DateTime time;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Details',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.7,
            ),
          ),
          centerTitle: true,
          backgroundColor: background_dark,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: textColor,
              ),
              onPressed: () {
                navigateBack(context);
              }),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              background.withOpacity(0.5),
              background.withOpacity(0.4),
              background.withOpacity(0.3),
              background.withOpacity(0.2),
              Colors.white,
              Colors.white,
            ],
            tileMode: TileMode.clamp,
          )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              const SizedBox(
                height: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: size.height / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: textColor,
                            blurRadius: 5,
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 1),
                      ]),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      IgnorePointer(
                        ignoring: true,
                        child: FlutterMap(
                          options: MapOptions(center: gps, zoom: 13.0),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://api.tomtom.com/map/1/tile/basic/main/"
                                  "{z}/{x}/{y}.png?key={apiKey}",
                              additionalOptions: const {"apiKey": apiKey},
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on,
                              size: 25.0, color: textColor),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            "Test's here",
                            style: TextStyle(
                                fontSize: size.height * 0.014,
                                letterSpacing: 1,
                                color: textColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Row(
                  children: [
                    Text(
                      test.modelName,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.025,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: textColor,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 1.0),
                        child: Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.014,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      color: textColor,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      intl.DateFormat('yyyy-MM-dd – kk:mm')
                          .format(time.toLocal()),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.019,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        CircularWidget(
                          size: size,
                          data: [
                            ChartData('normal', 7),
                            ChartData('test', test.pH)
                          ],
                          maximum: 14,
                          title: 'pH',
                        ),
                        CircularWidget(
                          size: size,
                          data: [
                            ChartData('normal', 10),
                            ChartData('test', test.turbidity)
                          ],
                          maximum: 60,
                          title: 'Turbidity',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        CircularWidget(
                          size: size,
                          data: [
                            ChartData('normal', 500),
                            ChartData('test', test.TDS)
                          ],
                          maximum: 10000,
                          title: 'TDS',
                        ),
                        CircularWidget(
                          size: size,
                          data: [
                            ChartData('normal', 30),
                            ChartData('test', test.Temperature)
                          ],
                          maximum: 50,
                          title: 'Temperature',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SmallDataChar(
                          size: size,
                          classification:
                              test.TDS > 400 ? 'Irregular' : 'Regular',
                          icon: Icons.electric_bolt_outlined,
                          name: "Conductivity",
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        SmallDataChar(
                          size: size,
                          classification: test.TDS < 400 ? 'Fine' : 'Critical',
                          name: "Oxygen",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}

class SmallDataChar extends StatelessWidget {
  SmallDataChar({
    super.key,
    required this.size,
    required this.classification,
    required this.name,
    this.icon = Icons.opacity_rounded,
  });

  final Size size;
  final String classification;
  final String name;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: background.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: textColor,
                blurRadius: 2,
                blurStyle: BlurStyle.outer,
                spreadRadius: 1),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: icon == Icons.opacity_rounded ? 0 : 15,
                  color: icon == Icons.opacity_rounded
                      ? background.withOpacity(0.2)
                      : textColor,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: size.height * 0.019,
                      letterSpacing: 1.5,
                      color: textColor,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: background.withOpacity(0.3),
                border: Border.all(
                  width: 0.5,
                  color: textColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  classification,
                  style: TextStyle(
                      fontSize: size.height * 0.025,
                      letterSpacing: 1.5,
                      color: textColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
