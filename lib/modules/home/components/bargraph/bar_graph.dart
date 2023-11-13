import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'individual_bar.dart';

class MyBarGraph extends StatelessWidget {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  const MyBarGraph({
    super.key,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });
  double _barMax(List<IndividualBar> myBarData) {
    double max = 0.0;
    for (var bar in myBarData) {
      if (bar.yAmount > max) {
        max = bar.yAmount;
      }
    }
    return max * 1.1;
  }

  Widget _getTitlesWidget(double value, TitleMeta meta) {
    const TextStyle style = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14.0);

    Text text;
    switch (value) {
      case 0:
        text = const Text("Su", style: style);
      case 1:
        text = const Text("M", style: style);
      case 2:
        text = const Text("Tu", style: style);
      case 3:
        text = const Text("W", style: style);
      case 4:
        text = const Text("Th", style: style);
      case 5:
        text = const Text("F", style: style);
      case 6:
        text = const Text("Sa", style: style);
      default:
        text = const Text("");
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  @override
  Widget build(BuildContext context) {
    List<IndividualBar> myBarData = [];
    myBarData = [
      IndividualBar(xIndex: 0, yAmount: sunAmount),
      IndividualBar(xIndex: 1, yAmount: monAmount),
      IndividualBar(xIndex: 2, yAmount: tueAmount),
      IndividualBar(xIndex: 3, yAmount: wedAmount),
      IndividualBar(xIndex: 4, yAmount: thuAmount),
      IndividualBar(xIndex: 5, yAmount: friAmount),
      IndividualBar(xIndex: 6, yAmount: satAmount),
    ];

    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
            show: true,
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: _getTitlesWidget,
              ),
            )),
        maxY: _barMax(myBarData),
        minY: 0,
        barGroups: myBarData
            .map(
              (data) => BarChartGroupData(
                x: data.xIndex,
                barRods: <BarChartRodData>[
                  BarChartRodData(
                    toY: data.yAmount <= 0 ? 0 : data.yAmount,
                    color: Colors.grey[800],
                    width: 25,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: _barMax(myBarData),
                      fromY: 0,
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
