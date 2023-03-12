import 'dart:ui';

import 'package:application_gp/Models/testData.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../Constants/constant.dart';
import '../../components/bluetooth.dart';
import '../../components/navigator.dart';

class NewScreen extends StatefulWidget {
  NewScreen({super.key, required this.position, required this.bluetooth}) {}
  final Position position;
  final Bluetooth bluetooth;
  @override
  State<NewScreen> createState() => _NewScreenState(position, bluetooth);
}

class _NewScreenState extends State<NewScreen>
    with SingleTickerProviderStateMixin {
  Position position;
  late final AnimationController pleaseController;
  late final Animation pleaseAnimation;
  testData? data;
  final Bluetooth bluetooth;
  _NewScreenState(this.position, this.bluetooth);

  @override
  void initState() {
    bluetooth.readData();
    pleaseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    pleaseController.repeat(reverse: true);

    pleaseAnimation = ColorTween(begin: textColor, end: Colors.white)
        .animate(pleaseController);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pleaseController.dispose();
    super.dispose();
  }

  void scanForDevices() async {
    // TODO:
  }

  MapController mapcontroller = MapController();
  bool isIgnored = false;
  bool isChosen = false;
  double percentage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Test',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !isChosen,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: size.height / 1.2,
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
                        ignoring: isIgnored,
                        child: FlutterMap(
                          mapController: mapcontroller,
                          options: MapOptions(
                              center:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 14.0),
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
                            "Target location",
                            style: TextStyle(
                                fontSize: size.height * 0.014,
                                letterSpacing: 1,
                                color: textColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Opacity(
                        opacity: isIgnored ? 0 : 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                print(mapcontroller.center);

                                setState(() {
                                  isIgnored = !isIgnored;
                                });
                              },
                              child: Container(
                                height: size.height / 25,
                                width: size.width / 6,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: textColor,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5.0,
                                      blurStyle: BlurStyle.inner,
                                      color: primaryColor,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.017,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IgnorePointer(
                        ignoring: !isIgnored,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 400),
                          opacity: isIgnored ? 1 : 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 600),
                              alignment: isIgnored
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () {
                                  if (!isIgnored) {}
                                  print(mapcontroller.center);

                                  setState(() {
                                    isIgnored = !isIgnored;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 600),
                                  height: size.height / 25,
                                  width: size.width / 6,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: textColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 25.0,
                                        blurStyle: BlurStyle.inner,
                                        color: isIgnored
                                            ? textColor.withOpacity(0.5)
                                            : primaryColor,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.017,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IgnorePointer(
                        ignoring: !isIgnored,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 400),
                          opacity: isIgnored ? 1 : 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 600),
                              alignment: isIgnored
                                  ? Alignment.bottomRight
                                  : Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () {
                                  print(mapcontroller.center);
                                  setState(() {
                                    isChosen = true;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 600),
                                  height: size.height / 23,
                                  width: size.width / 5,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: textColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 25.0,
                                        blurStyle: BlurStyle.inner,
                                        color: isIgnored
                                            ? textColor.withOpacity(0.5)
                                            : primaryColor,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.017,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 20.0,
                                blurStyle: BlurStyle.inner,
                                color: primaryColor,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Choose The Target Location',
                              style: TextStyle(
                                color: textColor,
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.bold,
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
            ),
            Visibility(
              visible: isChosen,
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 30,
                    width: size.width,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 2,
                            color: textColor,
                            blurStyle: BlurStyle.outer),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            width: size.width * (percentage / 100),
                            height: 30,
                            color: background_dark,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '%${percentage.toInt()}',
                      style: TextStyle(
                        fontSize: size.height * 0.025,
                        color: textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'The boat is navigating to your target.',
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: textColor,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: pleaseController,
                    builder: (context, child) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Please Wait...',
                        style: TextStyle(
                          fontSize: size.height * 0.025,
                          color: pleaseAnimation.value,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
