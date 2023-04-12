import 'dart:async';

import 'package:application_gp/components/navigator.dart';
import 'package:application_gp/components/rounded_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:geolocator/geolocator.dart';

import '../../Constants/constant.dart';
import '../../components/bluetooth.dart';
import '../../components/position.dart';
import 'Add_New.dart';

class BluetoothScreen extends StatefulWidget {
  BluetoothScreen({super.key, this.email, this.docId, this.position_local});
  String? email = 'none';
  String? docId = 'none';
  Position? position_local = Position(
      longitude: 31.2652,
      latitude: 29.1325,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  @override
  State<BluetoothScreen> createState() =>
      _BluetoothScreenState(email!, docId!, position_local!);
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  bool isOn = false;
  late Timer timer;
  final String email;
  final String docId;
  final Position position_local;

  _BluetoothScreenState(this.email, this.docId, this.position_local);
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      check();
    });

    super.initState();
  }

  Future<void> check() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
// Start scanning
    isOn = (await Bluetooth().checkIsOn())!;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              background,
              background.withOpacity(0.9),
              background.withOpacity(0.4),
              background.withOpacity(0.2),
              Colors.white,
              Colors.white,
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Bluetooth.png",
                width: size.width * .9,
              ),
              const SizedBox(
                height: 40,
              ),
              RoundedButton(
                  size: size,
                  title: isOn ? 'Continue' : 'Connect',
                  width: size.width / 2.5,
                  color: background_dark.withOpacity(0.8),
                  function: () async {
                    var bluetooth = Bluetooth();
                    bluetooth.devices.clear();
                    isOn ??= false;
                    if (!isOn) {
                      bluetooth.request_bluetooth();
                    } else {
                      await bluetooth.scanDevices();

                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Text(
                                    'Choose Device',
                                    style: TextStyle(
                                      fontSize: size.height * 0.020,
                                      fontWeight: FontWeight.w400,
                                      color: textColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      size: 18,
                                      Icons.refresh_rounded,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: bluetooth.devices.length,
                                        itemBuilder: (context, index) =>
                                            Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                color: background,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 5.0,
                                                    blurStyle: BlurStyle.outer,
                                                    color: textColor,
                                                  ),
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () async {
                                                  bluetooth.device =
                                                      bluetooth.devices[index];
                                                  int isConnected =
                                                      await bluetooth
                                                          .connectDevice();
                                                  if (isConnected == 0) {
                                                    // ignore: use_build_context_synchronously
                                                    GetPosition
                                                        .handleLocationPermission(
                                                            context);

                                                    Position position =
                                                        GetPosition(true).get();

                                                    //TODO
                                                    if (email != 'none' &&
                                                        docId != 'none') {
                                                      // ignore: use_build_context_synchronously
                                                      navigateTo(
                                                          context,
                                                          NewScreen(
                                                            email,
                                                            docId,
                                                            position:
                                                                position_local,
                                                            bluetooth:
                                                                bluetooth,
                                                          ));
                                                    } else {
                                                      // ignore: use_build_context_synchronously
                                                      navigateTo(
                                                          context,
                                                          NewScreen(
                                                            email,
                                                            docId,
                                                            position: position,
                                                            bluetooth:
                                                                bluetooth,
                                                          ));
                                                    }
                                                  } else {}
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      bluetooth.devices[index]
                                                              .name ??
                                                          'Unknown Device',
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.017,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: textColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      bluetooth.devices[index]
                                                          .address,
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.017,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: textColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            );
                          });
                        },
                      );
                    }
                  }),
              const SizedBox(
                height: 40,
              ),
              Text(
                'To continue, you must connect to your robot',
                style: TextStyle(
                  color: textColor,
                  fontSize: size.height * 0.015,
                  letterSpacing: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
