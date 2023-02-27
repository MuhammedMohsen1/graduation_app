import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../Constants/constant.dart';
import '../../components/functions.dart';
import '../../components/navigator.dart';

class NewScreen extends StatefulWidget {
  NewScreen({super.key, required this.position}) {}
  final Position position;
  @override
  State<NewScreen> createState() => _NewScreenState(position);
}

class _NewScreenState extends State<NewScreen> {
  Position position;

  _NewScreenState(this.position);
  @override
  void initState() {
    // TODO: implement initState
    scanForDevices();

    super.initState();
  }

  void scanForDevices() async {
    // Start scanning
    FlutterBlue flutterBlue = FlutterBlue.instance;
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something wit  h scan results
      print(results);
    });
// Stop scanning
    flutterBlue.stopScan();
  }

  MapController mapcontroller = MapController();
  bool isIgnored = false;

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
          children: [
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
                      ignoring: isIgnored,
                      child: FlutterMap(
                        mapController: mapcontroller,
                        options: MapOptions(
                            center:
                                LatLng(position!.latitude, position!.longitude),
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
                    Positioned(
                      bottom: 5,
                      right: 5,
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
                            borderRadius: BorderRadius.circular(10),
                            color: isIgnored
                                ? textColor.withOpacity(0.5)
                                : background,
                          ),
                          child: Text(
                            isIgnored ? 'cancel' : 'submit',
                            style: TextStyle(
                              color: isIgnored ? Colors.white : textColor,
                              fontSize: size.height * 0.017,
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
          ],
        ),
      ),
    );
  }
}
