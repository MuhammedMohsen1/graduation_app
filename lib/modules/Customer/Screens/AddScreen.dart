import 'package:application_gp/Constants/constant.dart';
import 'package:application_gp/components/navigator.dart';
import 'package:application_gp/modules/Customer/cubit/customer_cubit_cubit.dart';
import 'package:application_gp/modules/view_details/view_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

class AddScreen extends StatefulWidget {
  AddScreen({
    super.key,
  });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController pleaseController;
  late final Animation pleaseAnimation;

  MapController mapcontroller = MapController();
  bool isIgnored = false;
  bool isChosen = false;
  double percentage = 0;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cubit = CustomerCubitCubit.get(context);
    return Stack(
      children: [
        Visibility(
          visible: !isChosen,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: size.height / 1.35,
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
                          center: LatLng(cubit.position.latitude,
                              cubit.position.longitude),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'All Tests',
                    style: TextStyle(
                      color: textColor,
                      letterSpacing: 1.0,
                      fontSize: size.height * 0.022,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => AllTests(
                    size: size,
                    id: index + 1,
                    result: 'Polluted Water',
                    status: 'Done',
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class AllTests extends StatelessWidget {
  const AllTests({
    super.key,
    required this.size,
    required this.id,
    required this.result,
    required this.status,
  });

  final Size size;
  final int id;
  final String result;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, ViewDetails());
        },
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  blurRadius: 2, color: textColor, blurStyle: BlurStyle.outer),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test no. #$id',
                      style: TextStyle(
                        color: textColor,
                        letterSpacing: 1.0,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Result: ',
                          style: TextStyle(
                            color: textColor,
                            letterSpacing: 1.0,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                        Text(
                          result,
                          style: TextStyle(
                            color: Colors.red,
                            letterSpacing: 1.0,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(
                            color: textColor,
                            letterSpacing: 1.0,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                            color: Colors.green,
                            letterSpacing: 1.0,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right_outlined,
                  color: textColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
