import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/repositories/hora_repository.dart';
import 'package:bazi_app_frontend/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class LuckCalendarWidget extends StatefulWidget {
  const LuckCalendarWidget({required this.selectedMonth, super.key});

  final int selectedMonth;

  @override
  State<LuckCalendarWidget> createState() => _LuckCalendarWidgetState();
}

class _LuckCalendarWidgetState extends State<LuckCalendarWidget> {
  int currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: HoraRepository().getCalendarData(widget.selectedMonth + 1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: loadingWidget(),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("เกิดข้อผิดพลาดในการดึงข้อมูล"),
              );
            } else {
              return Expanded(
                child: TableCalendar(
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: fcolor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  locale: 'th_TH',
                  focusedDay:
                      DateTime(currentYear, widget.selectedMonth + 1, 1),
                  firstDay: DateTime.utc(
                      DateTime.now().year, widget.selectedMonth + 1, 1),
                  lastDay: DateTime.utc(
                      DateTime.now().year, widget.selectedMonth + 1, 31),
                  availableGestures: AvailableGestures.none,
                  headerVisible: false,
                  calendarFormat: CalendarFormat.month,
                  calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: snapshot.data!["goodDate"].contains(day.day)
                            ? Colors.lightGreen[300]
                            : snapshot.data!["badDate"].contains(day.day)
                                ? Colors.red[300]
                                : Theme.of(context).disabledColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
          } else {
            return SizedBox(
              child: Text("Error ${snapshot.error}"),
            );
          }
        });
  }
}
