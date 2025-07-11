import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TodayHoraChart extends StatelessWidget {
  const TodayHoraChart({required this.h, super.key});

  final List<dynamic> h;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: createBarGroups(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  'ย.${value.toInt() + 1}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> createBarGroups() {
    return List.generate(h.length, (index) {
      double topValue = h[index][0].toDouble();
      double bottomValue = h[index][1].toDouble();

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: topValue,
            fromY: bottomValue,
            width: 16,
            borderRadius: BorderRadius.zero,
            rodStackItems: [
              if (topValue > 0) BarChartRodStackItem(0, topValue, Colors.green),
              if (bottomValue < 0)
                BarChartRodStackItem(bottomValue, 0, Colors.red),
            ],
          ),
        ],
      );
    });
  }
}
