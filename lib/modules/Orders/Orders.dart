import 'package:application_gp/components/navigator.dart';
import 'package:application_gp/modules/add_new/Add_New.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../Constants/constant.dart';
import '../../components/bluetooth.dart';
import '../add_new/bluetooth_on.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.isBoat, required this.data});
  final bool isBoat;
  final List<Map<String, dynamic>> data;

  @override
  State<OrderScreen> createState() => _OrderScreenState(data);
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Map<String, dynamic>> data;

  _OrderScreenState(this.data);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          widget.isBoat ? 'BOATS' : 'TESTS',
          style: TextStyle(
            fontSize: size.height * 0.025,
            color: textColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              navigateBack(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: textColor,
            )),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
                border: Border.all(
                  width: 0.2,
                  color: textColor,
                ),
                color: background.withOpacity(0.35),
              ),
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        height: size.height * 0.16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            IgnorePointer(
                              ignoring: true,
                              child: FlutterMap(
                                options: MapOptions(
                                    center: LatLng(29.341089, 31.212216),
                                    zoom: 13.0),
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
                                    size: 20.0, color: textColor),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  "Test's here",
                                  style: TextStyle(
                                      fontSize: size.height * 0.012,
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
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 2.0),
                        child: Container(
                          height: 0.2,
                          color: textColor,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.isBoat) ...{
                                Text(
                                  'MOHSEN-1',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Version v1.0.0',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'A1976C2023',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Price: 8999.99 LE',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                              } else ...[
                                Text(
                                  widget.data[index]['email'].toString(),
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.018,
                                      letterSpacing: 1.5),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  '${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(widget.data[index]['time'])).inHours} hours ago',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.011,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.0),
                                ),
                              ]
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 2.0),
                              ElevatedButton(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: background_dark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () async {
                                  var bluetooth = Bluetooth();

                                  bool? isOn = await bluetooth.checkIsOn();
                                  isOn ??= false;
                                  if (!isOn) {
                                    Position positionLocal = Position(
                                        longitude: data[index]['gpsLong'],
                                        latitude: data[index]['gpsLat'],
                                        timestamp: DateTime.now(),
                                        accuracy: 1,
                                        altitude: 1,
                                        heading: 1,
                                        speed: 1,
                                        speedAccuracy: 1);

                                    navigateTo(
                                        context,
                                        BluetoothScreen(
                                            docId: data[index]['id'],
                                            email: data[index]['email'],
                                            position_local: positionLocal));
                                  }
                                  bluetooth.scanDevices().then((value) {
                                    setState(() {});
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              title: Row(
                                                children: [
                                                  Text(
                                                    'Choose Device',
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.height * 0.020,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: bluetooth
                                                            .devices.length,
                                                        itemBuilder:
                                                            (context, index1) =>
                                                                Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color:
                                                                        background,
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        5.0,
                                                                    blurStyle:
                                                                        BlurStyle
                                                                            .outer,
                                                                    color:
                                                                        textColor,
                                                                  ),
                                                                ]),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  bluetooth
                                                                      .device = bluetooth
                                                                          .devices[
                                                                      index1];
                                                                  int isConnected =
                                                                      await bluetooth
                                                                          .connectDevice();
                                                                  if (isConnected ==
                                                                      0) {
                                                                    print(
                                                                      data[index]
                                                                          [
                                                                          'gpsLat'],
                                                                    );
                                                                    print(
                                                                      data[index]
                                                                          [
                                                                          'gpsLong'],
                                                                    );
                                                                    Position position = Position(
                                                                        longitude: data[index]
                                                                            [
                                                                            'gpsLat'],
                                                                        latitude:
                                                                            data[index][
                                                                                'gpsLong'],
                                                                        timestamp:
                                                                            DateTime
                                                                                .now(),
                                                                        accuracy:
                                                                            1,
                                                                        altitude:
                                                                            1,
                                                                        heading:
                                                                            1,
                                                                        speed:
                                                                            1,
                                                                        speedAccuracy:
                                                                            1);
                                                                    navigateTo(
                                                                        context,
                                                                        NewScreen(
                                                                          data[index]
                                                                              [
                                                                              'email'],
                                                                          data[index]
                                                                              [
                                                                              'id'],
                                                                          position:
                                                                              position,
                                                                          bluetooth:
                                                                              bluetooth,
                                                                        ));

                                                                    setState(
                                                                        () {
                                                                      data.removeAt(
                                                                          index);
                                                                    });
                                                                  } else {}
                                                                },
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      bluetooth
                                                                              .devices[index1]
                                                                              .name ??
                                                                          'Unknown Device',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            size.height *
                                                                                0.017,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color:
                                                                            textColor,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      bluetooth
                                                                          .devices[
                                                                              index1]
                                                                          .address,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            size.height *
                                                                                0.017,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color:
                                                                            textColor,
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
                                          },
                                        );
                                      },
                                    );
                                  });

                                  print(bluetooth.devices);
                                },
                                child: Text(
                                  'Accept',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: size.height * 0.014,
                                      letterSpacing: 1.5),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
