import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import "package:http/http.dart" as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import "dart:convert" as convert;
import '../../Constants/constant.dart';
import '../../components/DetailsChar.dart';
import '../../components/navigator.dart';
import '../../layout/dashboard_layout.dart';

class ViewDetails extends StatelessWidget {
  const ViewDetails({super.key});

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
                          options: MapOptions(
                              center: LatLng(29.341089, 31.212216), zoom: 13.0),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://api.tomtom.com/map/1/tile/basic/main/"
                                  "{z}/{x}/{y}.png?key={apiKey}",
                              additionalOptions: {"apiKey": apiKey},
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
                      'MOHSEN-1',
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
                      '23/2/2023 - 8:56 PM',
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DetailsChar(
                      normal: 20,
                      range: 30,
                      test_data: 8.5,
                      variable_name: "TDS",
                      size: size,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DetailsChar(
                      normal: 7,
                      range: 14,
                      test_data: 8.5,
                      variable_name: "Ph",
                      size: size,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DetailsChar(
                      normal: 14,
                      range: 20,
                      test_data: 6.5,
                      variable_name: "Turbidly",
                      size: size,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DetailsChar(
                      normal: 32,
                      range: 40,
                      test_data: 12,
                      variable_name: "Temperature",
                      size: size,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SmallDataChar(
                          size: size,
                          classification: "Normal",
                          icon: Icons.electric_bolt_outlined,
                          name: "Conductivity",
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        SmallDataChar(
                          size: size,
                          classification: "Fine",
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
