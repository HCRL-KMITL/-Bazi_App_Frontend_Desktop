import 'package:bazi_app_frontend/constants/constants.dart';
import 'package:bazi_app_frontend/widgets/luck_calendar_widget.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final month = thaiMonth.values.toList();
  final monthValue = thaiMonth.keys.toList();
  int selectedMonth = DateTime.now().month - 1;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> items = List.generate(
        thaiMonth.length,
        (index) => DropdownMenuItem(
              value: monthValue[index],
              child: Text(month[index]),
            ));

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "ปฏิทินวันดีประจำปี ${DateTime.now().year + 543}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).disabledColor),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                value: monthValue[selectedMonth],
                items: items,
                onChanged: (value) {
                  setState(() {
                    selectedMonth = int.parse(value!) - 1;
                  });
                }),
          ),
          const SizedBox(height: 10),
          Text("สีน้ำเงิน = วันปัจจุบัน, สีเขียว = วันดี, สีแดง = วันอริ",
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 20),
          LuckCalendarWidget(selectedMonth: selectedMonth),
        ],
      ),
    ));
  }
}
