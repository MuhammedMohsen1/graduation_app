import 'package:application_gp/Constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/navigator.dart';
import '../../../layout/dashboard_layout.dart';
import '../../view_details/view_details.dart';
import '../../view_more/view_more.dart';
import '../../welcome_screen/welcome_screen.dart';
import '../Customer_Dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 14,
            right: 14,
            top: 14,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: textColor,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: Container(
                  width: size.width / 7,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/profile_photo.png'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Mohammed Mohsen',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .8,
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setBool('isLogin', false).then((value) {
                    pref.setBool('isEmployee', false).then((value) =>
                        navigateToAndReplace(context, const WelcomeScreen()));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: background_dark,
                      border: Border.all(
                        width: 0.5,
                        color: textColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign out',
                      style: TextStyle(
                          color: textColor,
                          fontSize: size.height * 0.015,
                          letterSpacing: 1.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                "assets/images/save_water.png",
                width: size.width * 0.5,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Keep it pure,',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w300,
                            fontSize: size.height * 0.032,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'water is yours.',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w300,
                              fontSize: size.height * 0.032,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'The nearest test',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w300,
                  fontSize: size.height * 0.032,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  navigateTo(context, ViewMore());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: background_dark,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'View more',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w300,
                              fontSize: size.height * 0.015,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: textColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: size.height / 4,
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
                    const Icon(Icons.location_on, size: 25.0, color: textColor),
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
        Row(
          children: [
            CircularWidget(
              size: size,
              data: [ChartData('normal', 7), ChartData('test', 2.45)],
              maximum: 14,
              title: 'pH',
            ),
            CircularWidget(
              size: size,
              data: [ChartData('normal', 2.5), ChartData('test', 7)],
              maximum: 20,
              title: 'Turbidity',
            ),
          ],
        ),
        Row(
          children: [
            CircularWidget(
              size: size,
              data: [ChartData('normal', 300), ChartData('test', 500)],
              maximum: 600,
              title: 'TDS',
            ),
            CircularWidget(
              size: size,
              data: [ChartData('normal', 2.5), ChartData('test', 1)],
              maximum: 3,
              title: 'Temperature',
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
        ),
        SizedBox(
          height: size.height / 10,
        ),
      ],
    );
  }
}
