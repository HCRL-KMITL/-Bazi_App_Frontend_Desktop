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
    final int month = widget.selectedMonth + 1;

    return FutureBuilder<Map<String, dynamic>>(
      future: HoraRepository().getCalendarData(widget.selectedMonth + 1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: loadingWidget());
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("เกิดข้อผิดพลาดในการดึงข้อมูล"),
            );
          } else {
            return Expanded(
              child: TableCalendar(
                calendarBuilders: CalendarBuilders(
                  todayBuilder: (context, day, focusedDay) {
                    return Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: fcolor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    final isGood = snapshot.data!["goodDate"].contains(day.day);
                    final isBad = snapshot.data!["badDate"].contains(day.day);

                    final BoxDecoration decoration;
                    final Color textColor;

                    if (isGood) {
                      decoration = const BoxDecoration(
                        color: Color(0xFF316141),
                        shape: BoxShape.circle,
                      );
                      textColor = Colors.white;
                    } else if (isBad) {
                      decoration = BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      );
                      textColor = Colors.white;
                    } else {
                      decoration = BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF862D2D), width: 1.5),
                      );
                      textColor = Colors.black;
                    }

                    return Container(
                      width: 38,
                      height: 38,
                      decoration: decoration,
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
                        ),
                      ),
                    );
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    return Container(
                      width: 38,
                      height: 38,
                      alignment: Alignment.center,
                      child: Text(
                        day.day.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    );
                  },
                ),
                daysOfWeekHeight: 40,
                locale: 'th_TH',
                focusedDay: DateTime(currentYear, month, 1),
                firstDay: DateTime(currentYear, month - 1, 25),
                lastDay: DateTime(currentYear, month + 1, 7), 
                availableGestures: AvailableGestures.none,
                headerVisible: false,
                calendarFormat: CalendarFormat.month,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: true,
                ),
              ),
            );
          }
        } else {
          return SizedBox(
            child: Text("Error ${snapshot.error}"),
          );
        }
      },
    );
  }
}
