import 'package:application_gp/Models/testData.dart';
import 'package:application_gp/components/GetData.dart';
import 'package:application_gp/components/updatingData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../Constants/constant.dart';
import '../../components/bluetooth.dart';
import '../../components/navigator.dart';
import '../view_details/view_details.dart';
import 'cubit/get_data_cubit.dart';

class NewScreen extends StatefulWidget {
  NewScreen(this.email, this.docId,
      {super.key, required this.position, required this.bluetooth});
  final Position position;
  final Bluetooth bluetooth;
  String email = 'none';
  String docId = 'none';
  @override
  State<NewScreen> createState() =>
      _NewScreenState(position, bluetooth, email, docId);
}

class _NewScreenState extends State<NewScreen>
    with SingleTickerProviderStateMixin {
  final String email;
  final String docId;
  Position position;
  late final AnimationController pleaseController;
  late final Animation pleaseAnimation;
  testData? data;
  final Bluetooth bluetooth;
  _NewScreenState(
    this.position,
    this.bluetooth,
    this.email,
    this.docId,
  );
  final status = [
    'Navigating Towards goal',
    'Collecting data',
    'Successful',
    'Navigating back ',
    'Done ',
  ];
  final errorCode = [
    'No Error',
    'Failed,Something went wrong please fix the issue and try again later',
  ];
  @override
  void initState() {
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
    pleaseController.dispose();
    bluetooth.close_connection();
    super.dispose();
  }

  MapController mapcontroller = MapController();
  bool isIgnored = false;
  bool isChosen = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GetDataCubit(),
      child: BlocConsumer<GetDataCubit, GetDataState>(
        listener: (context, state) async {
          mapcontroller.latLngToScreenPoint(LatLng(30.0156, 36.235));
          if (state is GetDataDone) {
            // TODO implement the result
            print('GetDataDone');
            bluetooth.connection?.close();
            if (email != 'none' && docId != 'none') {
              UpdateTestOrdersToFirestore(
                'test_orders',
                docId,
                'Drinkable Water',
              );
            }

            await addTestToFirestore(
              Getting_data.test.modelName,
              email,
              DateTime.now().millisecondsSinceEpoch,
              mapcontroller.center.latitude,
              mapcontroller.center.longitude,
              Getting_data.test.Temperature,
              Getting_data.test.turbidity,
              Getting_data.test.TDS,
              Getting_data.test.pH,
              0,
              0,
              0,
            );

            navigateBack(context);

            navigateTo(
                context,
                ViewDetails(
                  gps: LatLng(29.2651, 31.2658),
                  test: Getting_data.test,
                  time: DateTime.now(),
                ));
          }
        },
        builder: (context, state) {
          GetDataCubit cubit = GetDataCubit.get(context);
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
                                    center: LatLng(
                                        position.latitude, position.longitude),
                                    zoom: 14.0),
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
                                duration: const Duration(milliseconds: 400),
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
                                        duration:
                                            const Duration(milliseconds: 600),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                duration: const Duration(milliseconds: 400),
                                opacity: isIgnored ? 1 : 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AnimatedAlign(
                                    duration: const Duration(milliseconds: 600),
                                    alignment: isIgnored
                                        ? Alignment.bottomRight
                                        : Alignment.bottomCenter,
                                    child: InkWell(
                                      onTap: () async {
                                        print(mapcontroller.center);
                                        await bluetooth.sendData(
                                            '@${position.latitude.toString()},${position.longitude.toString()};');
                                        print('Before reading');
                                        cubit.readData(bluetooth);
                                        setState(() {
                                          isChosen = true;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 600),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                        Text(
                          'Tracking BOAT',
                          style: TextStyle(
                            fontSize: size.height * 0.025,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: size.height / 2.5,
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
                                        center: LatLng(
                                            Getting_data.test.gps_lat,
                                            Getting_data.test.gps_long),
                                        zoom: 15.0),
                                    children: [
                                      TileLayer(
                                        urlTemplate:
                                            "https://api.tomtom.com/map/1/tile/basic/main/"
                                            "{z}/{x}/{y}.png?key={apiKey}",
                                        additionalOptions: const {
                                          "apiKey": apiKey
                                        },
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
                                      "Boat is here",
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
                          height: 50.0,
                        ),
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
                                  duration: const Duration(milliseconds: 2500),
                                  width: size.width * (cubit.percentage / 100),
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
                            cubit.percentage.toInt() == 95
                                ? '%100'
                                : '%${cubit.percentage.toInt()}',
                            style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: textColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            Getting_data.test.errorCode != 0
                                ? errorCode[Getting_data.test.errorCode]
                                : status[Getting_data.test.status],
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              color: Getting_data.test.errorCode != 0
                                  ? Colors.red
                                  : textColor,
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
        },
      ),
    );
  }
}
