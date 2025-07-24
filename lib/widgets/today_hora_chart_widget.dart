import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TodayHoraChart extends StatelessWidget {
  const TodayHoraChart({required this.h, super.key});

  final List<dynamic> h;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: createBarGroups(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'ย.${value.toInt() + 1}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

List<BarChartRodStackItem> generateStackItemsWithGradient(
    double from, double to, Color startColor, Color endColor) {
  List<BarChartRodStackItem> items = [];

  int steps = 100;
  if (steps < 1 || from == to) return items;

  double stepSize = (to - from) / steps;

  for (int i = 0; i < steps; i++) {
    double start = from + i * stepSize;
    double end = start + stepSize;
    Color color = Color.lerp(startColor, endColor, i / (steps - 1))!;
    items.add(BarChartRodStackItem(start, end, color));
  }

  return items;
}



  List<BarChartGroupData> createBarGroups() {
    return List.generate(h.length, (index) {
      double topValue = h[index][0].toDouble();
      double bottomValue = h[index][1].toDouble();

      List<BarChartRodStackItem> stackItems = [];

      if (bottomValue < 0) {
        stackItems.addAll(generateStackItemsWithGradient(
          bottomValue,
          0,
          const Color(0xFF862D2D),
          const Color(0xFFcbbcbc),
        ));
      }

      if (topValue > 0) {
        stackItems.addAll(generateStackItemsWithGradient(
          0,
          topValue,
          const Color(0xFFbec6c1),
          const Color(0xFF316141),
        ));
      }

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            fromY: bottomValue < 0 ? bottomValue : 0,
            toY: topValue > 0 ? topValue : 0,
            width: 12,
            rodStackItems: stackItems,
            borderRadius: BorderRadius.circular(20),
          ),
        ],
      );
    });
  }
}
