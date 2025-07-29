import 'dart:math';

import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/constants/constants.dart';
import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/authentication_repository.dart';
import 'package:bazi_app_frontend/repositories/hora_repository.dart';
import 'package:bazi_app_frontend/widgets/monthly_prediction_widget.dart';
import 'package:bazi_app_frontend/widgets/today_hora_chart_widget.dart';
import 'package:bazi_app_frontend/widgets/forecast_widget.dart';
import 'package:bazi_app_frontend/widgets/luck_calendar_widget.dart';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uiw.dart';
import 'package:intl/intl.dart';


class HomeWidget extends StatefulWidget {
  const HomeWidget({required this.userData, super.key});

  final UserModel userData;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final month = thaiMonth.values.toList();
  final monthValue = thaiMonth.keys.toList();
  int selectedMonth = DateTime.now().month - 1;
  Map<String, dynamic> todayHora = {};
  List<String?> bestTime = [];
  Map<String, Iconify> dayStatusIcon = {
    "Good": const Iconify(Uiw.smile, size: 50),
    "Bad": const Iconify(Uiw.frown, size: 50),
    "Neutral": const Iconify(Uiw.meh, size: 50)
  };

  @override
  void initState() {
    super.initState();
    getDailyHora();
  }

  void getDailyHora() async {
    final horaToday = await HoraRepository().getDailyHora();
    List<int> scoreList = List.generate(horaToday["hours"].length, (index) {
      return horaToday["hours"][index][0] + horaToday["hours"][index][1];
    });
    int maxScore = scoreList.reduce(max);
    List<String?> bestTimeIndex = [];
    for (int i = 0; i < scoreList.length; i++) {
      if (scoreList[i] == maxScore) {
        bestTimeIndex.add(yam[i + 1]);
      }
    }
    print("Today Hora: $horaToday");
    if (!mounted) return;
    setState(() {
      todayHora = horaToday;
      bestTime = bestTimeIndex;
    });
  }

  String formatThaiDate(DateTime date) {
    final thaiYear = date.year + 543;
    final formatter = DateFormat('d MMMM', 'th');
    final dayMonth = formatter.format(date);
    return '$dayMonth $thaiYear';
  }

  List<DropdownMenuItem<String>> get monthItems => List.generate(
        thaiMonth.length,
        (index) => DropdownMenuItem(
          value: monthValue[index],
          child: Text(month[index]),
        ),
      );

  Widget build(BuildContext context) {
      return Row(
      children: [
        Expanded(
          flex: 1,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        todayHora.isEmpty
                            ? dayStatusIcon["Neutral"]!
                            : dayStatusIcon[todayHora["status"]]!,
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatThaiDate(DateTime.now()),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              "สวัสดี! คุณ ${widget.userData.name}",
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          iconSize: 30,
                          color: wColor,
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                              backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).primaryColor)),
                          onPressed: () async {
                            await AuthenticationRepository().signOut();
                          },
                          icon: const Icon(Icons.logout)
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'คะแนนประจำวันของคุณ',
                            style: Theme.of(context).textTheme.headlineSmall,
                            children: [
                              TextSpan(
                                text: ' (คะแนน/เวลา)',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).disabledColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 200,
                        child: todayHora.isEmpty
                            ? const Center(child: Text("กำลังโหลด..."))
                            : TodayHoraChart(h: todayHora["hours"]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ช่วงเวลาที่ดีที่สุดสำหรับคุณในวันนี้คือ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 10),
                        GridView.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 10,
                          shrinkWrap: true, //เนื้อหาไม่เกินกรอบ
                          childAspectRatio: 2.5,
                          physics: const NeverScrollableScrollPhysics(), //ป้องกันการ column ทับกัน
                          children: bestTime.map((time) {
                            return Container(
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                color: fcolor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  time!,
                                  style: Theme.of(context).textTheme.bodyMediumWcolor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text("สีประจำวัน ",
                            style: Theme.of(context).textTheme.headlineSmall),
                        if (todayHora.containsKey("colors"))
                          ...((todayHora["colors"] as List)
                              .map(
                                (colorName) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0), // Adjust spacing
                                  child:
                                      colorDisplaying[colorName] ?? const SizedBox(),
                                ),
                              )
                              .toList()),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ForecastTabs(todayHora: todayHora)
                  ],
                ),
              ),
            ),
          )
        ),



        // Column2
        Expanded(
          flex: 1,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100,),
                    Center(
                      child: Text(
                        "ปฏิทินวันดีประจำปี ${DateTime.now().year + 543}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        isExpanded: true,
                        iconEnabledColor: Colors.white,
                        value: monthValue[selectedMonth],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                        selectedItemBuilder: (BuildContext context) {
                          return monthValue.map<Widget>((String i) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                thaiMonth[i] ?? '',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: wColor),
                              ),
                            );
                          }).toList();
                        },
                        items: monthValue.map<DropdownMenuItem<String>>((String i) {
                          return DropdownMenuItem<String>(
                            value: i,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                thaiMonth[i] ?? '',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedMonth = int.parse(value!) - 1;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 35),
                    LuckCalendarWidget(selectedMonth: selectedMonth),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('วันนี้'),
                          const SizedBox(width: 20),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Color(0xFF316141),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('วันดี'),
                          const SizedBox(width: 20),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('วันอริ'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          )
        ),



        // Column3
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue,
            child: Text('Column 3'),
          ),
        ),
      ]
    );
  }
}
