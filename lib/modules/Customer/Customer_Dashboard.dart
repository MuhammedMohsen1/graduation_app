import 'package:application_gp/Constants/constant.dart';
import 'package:application_gp/components/navigator.dart';
import 'package:application_gp/components/position.dart';
import 'package:application_gp/modules/Customer/cubit/customer_cubit_cubit.dart';
import 'package:application_gp/modules/view_more/view_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:latlong2/latlong.dart';
import '../../components/GetData.dart';
import '../../components/updatingData.dart';
import '../../layout/dashboard_layout.dart';
import '../view_details/view_details.dart';
import 'Screens/HomeScreen.dart';

class Customer_Dashboard extends StatefulWidget {
  const Customer_Dashboard({super.key});

  @override
  State<Customer_Dashboard> createState() => _Customer_DashboardState();
}

class _Customer_DashboardState extends State<Customer_Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CustomerCubitCubit(),
      child: BlocConsumer<CustomerCubitCubit, CustomerCubitState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = CustomerCubitCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Container(
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
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                        cubit.screens[cubit.screenIndex],
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 48.0, vertical: 16),
                        child: Container(
                          height: size.height / 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 7.5,
                                  color: primaryColor,
                                  blurStyle: BlurStyle.inner)
                            ],
                          ),
                          child: Row(children: [
                            BottomIcon(
                              cubit: cubit,
                              index: 0,
                              icon: Icons.home_rounded,
                            ),
                            BottomIcon(
                              cubit: cubit,
                              index: 1,
                              icon: LineIcons.plus,
                            ),
                            BottomIcon(
                              cubit: cubit,
                              index: 2,
                              icon: LineIcons.creditCard,
                            ),
                            BottomIcon(
                              cubit: cubit,
                              index: 3,
                              icon: LineIcons.ship,
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CircularWidget extends StatelessWidget {
  const CircularWidget({
    super.key,
    required this.size,
    required this.title,
    required this.data,
    required this.maximum,
  });

  final Size size;
  final String title;
  final List<ChartData> data;
  final double maximum;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size.height / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2.0,
                  blurStyle: BlurStyle.outer,
                  color: textColor,
                ),
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: size.height * 0.017,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Expanded(
                child: SfCircularChart(
                  legend:
                      Legend(isVisible: true, position: LegendPosition.bottom
                          // Border color and border width of legend
                          ),
                  margin: EdgeInsets.zero,
                  series: <CircularSeries>[
                    // Render radial chart

                    RadialBarSeries<ChartData, String>(
                      dataSource: data,
                      animationDuration: 600,
                      animationDelay: 200,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      maximumValue: maximum,
                      cornerStyle: CornerStyle.endCurve,
                      useSeriesColor: true,
                      trackOpacity: 0.15,
                      dataLabelSettings: DataLabelSettings(
                        // Renders the data label
                        isVisible: true,
                        textStyle: TextStyle(
                            fontSize: size.height * 0.011,
                            color: textColor,
                            letterSpacing: 1),
                      ),
                    )
                  ],
                  palette: [primaryColor, background_dark],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomIcon extends StatelessWidget {
  const BottomIcon({
    super.key,
    required this.cubit,
    required this.index,
    required this.icon,
  });
  final int index;
  final CustomerCubitCubit cubit;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          cubit.changeTheScreen(index);
        },
        child: SizedBox(
          height: size.height / 17,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Icon(
              icon,
              shadows: [
                Shadow(
                    color: cubit.screenIndex == index
                        ? Colors.black
                        : Colors.transparent,
                    blurRadius: 20.0)
              ],
              color: cubit.screenIndex == index ? background : textColor,
            ),
          ),
        ),
      ),
    );
  }
}
