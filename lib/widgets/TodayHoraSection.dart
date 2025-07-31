// ignore: file_names
import 'package:flutter/material.dart';
import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/widgets/today_hora_chart_widget.dart';

class TodayHoraSection extends StatelessWidget {
  final Map<String, dynamic> todayHora;
  final List<String?> bestTime;

  const TodayHoraSection({
    super.key,
    required this.todayHora,
    required this.bestTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text.rich(
            TextSpan(
              text: 'คะแนนในแต่ละยามประจำวันนี้',
              style: Theme.of(context).textTheme.headlineSmall,
              children: [
                TextSpan(
                  text: ' (คะแนน/เวลา)',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          )
        ),
        const SizedBox(height: 20),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).primaryColor, width: 2),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 200,
            child: todayHora.isEmpty
                ? const Center(child: Text("กำลังโหลด..."))
                : TodayHoraChart(h: todayHora["hours"]),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "ช่วงเวลาที่ดีที่สุดสำหรับคุณในวันนี้คือ",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.0),
        ),
        const SizedBox(height: 20,),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: bestTime.map((time) {
            return SizedBox(
              width: 140,
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: fcolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    time ?? '',
                    style: Theme.of(context).textTheme.bodyMediumWcolor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
