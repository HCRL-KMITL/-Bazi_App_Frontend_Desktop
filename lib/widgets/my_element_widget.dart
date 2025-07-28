import 'package:bazi_app_frontend/models/bazichart_model.dart';
import 'package:bazi_app_frontend/widgets/four_pillar_table_widget.dart';
import 'package:flutter/material.dart';

class TopCircleOnly extends StatelessWidget {
  const TopCircleOnly({required this.chart, super.key});

  final BaziChart chart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: pillarCell(chart.dayPillar.heavenlyStem,
          fontSizeCharacter: 40, fontSizeSpelling: 20, isCircle: true),
    );
  }
}
