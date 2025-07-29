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
                  defaultBuilder: (context, day, focusedDay) {
                    final isToday = day.year == DateTime.now().year &&
                                    day.month == DateTime.now().month &&
                                    day.day == DateTime.now().day;

                    final isGood = snapshot.data!["goodDate"].contains(day.day);
                    final isBad = snapshot.data!["badDate"].contains(day.day);

                    // print("badDate: ${snapshot.data!["badDate"]}");
                    // print("Type: ${snapshot.data!["badDate"].runtimeType}");


                    final Color bgColor;
                    final Color textColor;

                    if (isGood) {
                      bgColor = const Color(0xFF316141);
                      textColor = Colors.white;
                    } else if (isBad) {
                      bgColor = Theme.of(context).primaryColor;
                      textColor = Colors.white;
                    } else {
                      bgColor = Colors.transparent;
                      textColor = Colors.black;
                    }

                    Widget dayWidget = Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: bgColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        day.day.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
                      ),
                    );

                    if (isToday) {
                      dayWidget = Container(
                        width: 51,
                        height: 51,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: fcolor, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: dayWidget,
                      );
                    }
                    return dayWidget;
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    return Container(
                      width: 45,
                      height: 45,
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
                  todayDecoration: BoxDecoration(),
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
