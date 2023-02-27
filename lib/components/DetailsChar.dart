import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Constants/constant.dart';
import '../layout/dashboard_layout.dart';

class DetailsChar extends StatelessWidget {
  const DetailsChar({
    super.key,
    required this.normal,
    required this.test_data,
    required this.range,
    required this.variable_name,
    required this.size,
  });

  final double normal;
  final double test_data;
  final double range;
  final String variable_name;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 3,
      decoration: BoxDecoration(
        border: Border.all(color: textColor, width: 0.4),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: textColor.withOpacity(0.5),
              blurRadius: 4,
              blurStyle: BlurStyle.outer),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SfCartesianChart(
            plotAreaBorderColor: textColor,
            primaryXAxis: CategoryAxis(),
            borderColor: Colors.transparent,
            legend: Legend(
                isVisible: true,
                orientation: LegendItemOrientation.horizontal,
                position: LegendPosition.bottom),
            primaryYAxis: NumericAxis(minimum: 0, maximum: range, interval: 2),
            series: <ChartSeries<ChartData, String>>[
              StackedColumnSeries<ChartData, String>(
                groupName: "GroupA",
                legendIconType: LegendIconType.rectangle,
                legendItemText: "test data",
                dataSource: [
                  ChartData(variable_name, test_data, background),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: primaryColor,
              ),
              StackedColumnSeries<ChartData, String>(
                groupName: "GroupB",
                legendIconType: LegendIconType.rectangle,
                legendItemText: "normal",
                dataSource: [
                  ChartData(variable_name, normal, background),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: background_dark,
              ),
            ]),
      ),
    );
  }
}
