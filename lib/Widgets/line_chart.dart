import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Core/app_colors/app_colors.dart';

class LineChartWidget extends StatelessWidget {
  //final List<int> showingTooltipOnSpots;
  final List<FlSpot> allSpots;
  //final ValueChanged<int> onSpotTapped;

  const LineChartWidget({
    //required this.showingTooltipOnSpots,
    required this.allSpots,
    //required this.onSpotTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        // showingTooltipIndicators: showingTooltipOnSpots.map((index) {
        //   return ShowingTooltipIndicators([
        //     LineBarSpot(
        //       LineChartBarData(
        //         spots: allSpots,
        //       ),
        //       0,
        //       allSpots[index],
        //     ),
        //   ]);
        // }).toList(),
        lineTouchData: LineTouchData(
          handleBuiltInTouches: false,
          touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
            if (event is FlTapUpEvent && response?.lineBarSpots != null) {
              //onSpotTapped(response!.lineBarSpots!.first.spotIndex);
            }
          },
        ),
        lineBarsData: [
          LineChartBarData(
            spots: allSpots,
            isCurved: false,
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              //color: AppColors.primaryColor2.withOpacity(0.4),
              color: const Color(0xFFF6D2D3),
            ),
            dotData: const FlDotData(show: false),
            gradient: LinearGradient(colors: AppColors.primaryG),
          ),
        ],
        titlesData: const FlTitlesData(show: false),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        minY: 0,
        maxY: 130,
      ),
    );
  }
}
