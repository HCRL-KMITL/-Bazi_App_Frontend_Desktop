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

Map<String, Color> getDayColors(BuildContext context, DateTime day, Map<String, dynamic> data) {
  final int d = day.day;
  if (data["goodDate"]!.contains(d)) {
    return {
      "bg": const Color(0xFF316141),
      "text": Colors.white,
    };
  } else if (data["badDate"]!.contains(d)) {
    return {
      "bg": Theme.of(context).primaryColor,
      "text": Colors.white,
    };
  } else {
    return {
      "bg": wColor,
      "text": Colors.black,
    };
  }
}

class _LuckCalendarWidgetState extends State<LuckCalendarWidget> {
  int currentYear = DateTime.now().year;
  late Future<Map<String, dynamic>> _calendarFuture;

  @override
  void initState() {
    super.initState();
    _calendarFuture = HoraRepository().getCalendarData(widget.selectedMonth + 1);
  }

  @override
  void didUpdateWidget(covariant LuckCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedMonth != widget.selectedMonth) {
      // โหลดข้อมูลใหม่เฉพาะตอนเดือนเปลี่ยน
      _calendarFuture = HoraRepository().getCalendarData(widget.selectedMonth + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int month = widget.selectedMonth + 1;

    return FutureBuilder<Map<String, dynamic>>(
      future: _calendarFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: loadingWidget());
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("เกิดข้อผิดพลาดในการดึงข้อมูล"),
            );
          } else {
            return TableCalendar(
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final dayColors = getDayColors(context, day, snapshot.data!);
                  final bgColor = dayColors["bg"]!;
                  final textColor = dayColors["text"]!;
                  final bool isGood = snapshot.data!["goodDate"].contains(day.day);
                  final bool isBad = snapshot.data!["badDate"].contains(day.day);

                  final decoration = bgColor == Colors.transparent
                      ? BoxDecoration(
                          color: bgColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF862D2D), width: 2.5),
                        )
                      : BoxDecoration(
                          color: bgColor,
                          shape: BoxShape.circle,
                        );

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: decoration,
                      alignment: Alignment.center,
                      child: Text(
                        day.day.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
                      ),
                    )
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  final dayColors = getDayColors(context, day, snapshot.data!);
                  final bgColor = dayColors["bg"]!;
                  final textColor = dayColors["text"]!;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: bgColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[700]!,
                            spreadRadius: 3,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(color: textColor),
                      ),
                    )
                  );
                },
                outsideBuilder: (context, day, focusedDay) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Container(
                      width: 45,
                      height: 45,
                      alignment: Alignment.center,
                      child: Text(
                        day.day.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    )
                  );
                },
              ),
              daysOfWeekHeight: 30,
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