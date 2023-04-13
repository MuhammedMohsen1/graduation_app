import 'package:application_gp/Constants/constant.dart';
import 'package:application_gp/components/navigator.dart';
import 'package:application_gp/components/position.dart';
import 'package:application_gp/components/updatingData.dart';
import 'package:application_gp/modules/add_new/bluetooth_on.dart';
import 'package:application_gp/modules/login_screen/Sign_Up.dart';
import 'package:application_gp/modules/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart'
    as positioned;
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../components/bluetooth.dart';
import '../components/view_more_button.dart';
import '../modules/Orders/Orders.dart';
import '../modules/add_new/Add_New.dart';
import '../modules/view_more/view_more.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({super.key});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  List<Map<String, dynamic>> data = [];
  int pollutedWater = 0;
  List<Map<String, dynamic>> testorders = [];
  List<Map<String, dynamic>> boatorders = [];
  double percentage = 0;
  @override
  void initState() {
    // TODO: implement initState
    get();

    super.initState();
  }

  Future<void> get() async {
    pollutedWater = 0;
    fetchTestsFromFirestore().then((value) {
      setState(() {
        data = value;
      });
      for (var element in data) {
        if (element['polluted'] == 0) {
          pollutedWater++;
          percentage = (pollutedWater / data.length) * 100;
          setState(() {});
        }
      }

      print('done fetching data');
    });
    fetchBoatOrdersFromFirestore().then((value) {
      setState(() {
        boatorders = value;
      });
      print('done fetching Test Orders');
    });

    fetchTestOrdersFromFirestore().then((value) {
      print(value);
      value.removeWhere((element) {
        print(element['status']);
        if (element['status'] != 'waiting...') {
          return true;
        }
        return false;
      });
      print(value);
      setState(() {
        testorders = value;
      });
      print('done fetching Test Orders');
    });
  }

  @override
  Widget build(BuildContext context) {
    print(data);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      decoration: BoxDecoration(
                          color: borderColor,
                          border: Border.all(
                            color: borderColor,
                            width: 1,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 2.0,
                        ),
                        child: Text(
                          'dev',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                          ),
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
                              navigateToAndReplace(
                                  context, const WelcomeScreen()));
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
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w300,
                        fontSize: size.height * 0.06,
                        letterSpacing: 1,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: get,
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: textColor,
                        )),
                    const SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: size.width,
                height: size.height / 3,
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Container(
                        width: size.width / 1.05,
                        height: (size.height / 3.5) / 1.2,
                        color: background,
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 14,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 14,
                            ),
                            child: Container(
                              width: size.width / 2,
                              height: size.height / 3,
                              decoration: BoxDecoration(
                                color: background_dark,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Tests',
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.height * 0.03,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    data.length.toString(),
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.height * 0.03,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    width: size.width / 2.8,
                                    child: ViewMoreButton(
                                      size: size,
                                      title: 'View more',
                                      screen: ViewMore(data: data),
                                      color: backgroundBtn,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: background,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SizedBox(
                                      height: size.height * .075,
                                      child: ElevatedButton(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: background_dark,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                        onPressed: () async {
                                          var bluetooth = Bluetooth();

                                          bool? isOn =
                                              await bluetooth.checkIsOn();
                                          isOn ??= false;
                                          if (!isOn) {
                                            navigateTo(
                                                context, BluetoothScreen());
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
                                                                  size.height *
                                                                      0.020,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                                              Icons
                                                                  .refresh_rounded,
                                                              color: textColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    bluetooth
                                                                        .devices
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                            index) =>
                                                                        Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: const BoxDecoration(
                                                                        color:
                                                                            background,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                5.0,
                                                                            blurStyle:
                                                                                BlurStyle.outer,
                                                                            color:
                                                                                textColor,
                                                                          ),
                                                                        ]),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          bluetooth.device =
                                                                              bluetooth.devices[index];
                                                                          int isConnected =
                                                                              await bluetooth.connectDevice();
                                                                          if (isConnected ==
                                                                              0) {
                                                                            GetPosition.handleLocationPermission(context);

                                                                            positioned.Position
                                                                                position =
                                                                                GetPosition(true).get();

                                                                            navigateTo(
                                                                                context,
                                                                                NewScreen(
                                                                                  'none',
                                                                                  'none',
                                                                                  position: position,
                                                                                  bluetooth: bluetooth,
                                                                                ));
                                                                          } else {}
                                                                        },
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              bluetooth.devices[index].name ?? 'Unknown Device',
                                                                              style: TextStyle(
                                                                                fontSize: size.height * 0.017,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: textColor,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              bluetooth.devices[index].address,
                                                                              style: TextStyle(
                                                                                fontSize: size.height * 0.017,
                                                                                fontWeight: FontWeight.w400,
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
                                                  },
                                                );
                                              },
                                            );
                                          });

                                          print(bluetooth.devices);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.add,
                                              color: textColor,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'New',
                                              style: TextStyle(
                                                  fontSize: size.height * 0.025,
                                                  letterSpacing: 1.7,
                                                  color: textColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.elliptical(200, 100)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Total Polluted water',
                                          style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: size.height * 0.015,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        Text(
                                          '$pollutedWater place',
                                          style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: size.height * 0.03,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: size.height / 8,
                        width: size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              height: size.height / 8,
                              width: size.width / 4,
                              child: SfCircularChart(
                                margin: EdgeInsets.zero,
                                series: <CircularSeries>[
                                  // Render pie chart
                                  PieSeries<ChartData, String>(
                                    enableTooltip: true,
                                    dataSource: [
                                      ChartData(
                                          'polluted', percentage, background),
                                      ChartData('clean', (100 - percentage),
                                          background_dark),
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    pointColorMapper: (ChartData data, _) =>
                                        data.color,
                                    radius: '70%',
                                  ),
                                ],
                                palette: const [background, background_dark],
                              ),
                            ),
                            SizedBox(
                              height: size.height / 8,
                              width: size.width - (size.width / 4),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, right: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'clean water',
                                            style: TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.w300,
                                              fontSize: size.height * 0.0178,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '%${100 - percentage}',
                                          style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: size.height * 0.0178,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    SizedBox(
                                      height: 1,
                                      child: Container(
                                        color: textColor.withOpacity(0.3),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'polluted water',
                                            style: TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.w300,
                                              fontSize: size.height * 0.0178,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '%$percentage',
                                          style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: size.height * 0.0178,
                                            letterSpacing: 1,
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
                      ),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: size.height * .075,
                            child: ElevatedButton(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: background_dark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: () async {
                                navigateTo(
                                    context,
                                    Sign_Up_Screen(
                                      isEmployee: true,
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.person_add_alt_1_rounded,
                                    color: textColor,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    'Hire an employee',
                                    style: TextStyle(
                                        fontSize: size.height * 0.025,
                                        letterSpacing: 1.7,
                                        color: textColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20))),
                                child: SizedBox(
                                  height: size.height * .075,
                                  child: ElevatedButton(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: background_dark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    onPressed: () {
                                      navigateTo(
                                          context,
                                          OrderScreen(
                                            isBoat: true,
                                            data: boatorders,
                                          ));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Icon(
                                                LineIcons.ship,
                                                color: textColor,
                                              ),
                                            ),
                                            Positioned(
                                              right: 0.0,
                                              top: 1.0,
                                              child: Container(
                                                width: 15.0,
                                                height: 15.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.red.shade300,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Text(
                                                    boatorders.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          size.height * 0.012,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          'BOAT Orders',
                                          style: TextStyle(
                                              fontSize: size.height * 0.016,
                                              letterSpacing: 1.7,
                                              color: textColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20))),
                                child: SizedBox(
                                  height: size.height * .075,
                                  child: ElevatedButton(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: background_dark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    onPressed: () {
                                      navigateTo(
                                          context,
                                          OrderScreen(
                                            isBoat: false,
                                            data: testorders,
                                          ));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Icon(
                                                LineIcons.clipboardList,
                                                color: textColor,
                                              ),
                                            ),
                                            Positioned(
                                              right: 1.0,
                                              top: 1.0,
                                              child: Container(
                                                width: 15.0,
                                                height: 15.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.red.shade300,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Text(
                                                    testorders.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          size.height * 0.012,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          'Test Orders',
                                          style: TextStyle(
                                              fontSize: size.height * 0.016,
                                              letterSpacing: 1.7,
                                              color: textColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color = textColor]);
  final String x;
  final double y;
  final Color color;
}
