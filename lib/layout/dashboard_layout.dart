import 'package:application_gp/Constants/constant.dart';
import 'package:application_gp/components/navigator.dart';
import 'package:application_gp/components/rounded_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components/view_more_button.dart';
import '../modules/view_more/view_more.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25),
      ChartData('Steve', 38),
    ];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: background,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 35,
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
                  Container(
                    decoration: const BoxDecoration(
                        color: background_dark, shape: BoxShape.circle),
                    child: IconButton(
                      color: textColor,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bluetooth,
                        size: 20,
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
              child: Text(
                'Dashboard',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w300,
                  fontSize: size.height * 0.06,
                  letterSpacing: 1,
                ),
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
                                  '125,67K',
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
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: background_dark,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Row(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        '12 place',
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
            Container(
              width: size.width,
              color: Colors.white,
              child: Column(
                children: [
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
                                  ChartData('polluted', 19.35, background),
                                  ChartData('clean', 80.65, background_dark),
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color,
                                radius: '70%',
                              ),
                            ],
                            palette: [background, background_dark],
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
                                      '%80.65',
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
                                      '%19.35',
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
                  SizedBox(
                    width: size.width,
                    height: size.height / 20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Last Test',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.0175,
                              letterSpacing: 1,
                            ),
                          ),
                          const Spacer(),
                          ViewMoreButton(
                            size: size,
                            screen: const ViewMore(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height / 4.07,
                    child: SfCartesianChart(
                        margin: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        primaryXAxis: CategoryAxis(),
                        borderWidth: 1.0,
                        primaryYAxis:
                            NumericAxis(minimum: 0, maximum: 40, interval: 5),
                        borderColor: textColor,
                        series: <ChartSeries<ChartData, String>>[
                          StackedColumnSeries<ChartData, String>(
                            groupName: "GroupA",
                            dataSource: [
                              ChartData('ph', 9, background),
                              ChartData('temperature', 30.45, background_dark),
                              ChartData('TDS', 20, background),
                              ChartData('turbidity', 15, background_dark),
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            color: primaryColor,
                          ),
                          StackedColumnSeries<ChartData, String>(
                            groupName: "GroupB",
                            dataSource: [
                              ChartData('ph', 7, background),
                              ChartData('temperature', 37, background_dark),
                              ChartData('TDS', 5, background),
                              ChartData('turbidity', 10, background_dark),
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            color: background_dark,
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ],
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
