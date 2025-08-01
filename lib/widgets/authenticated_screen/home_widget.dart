import 'dart:math';
import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/constants/constants.dart';
import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/authentication_repository.dart';
import 'package:bazi_app_frontend/repositories/hora_repository.dart';
import 'package:bazi_app_frontend/widgets/TodayHoraSection.dart';
import 'package:bazi_app_frontend/widgets/monthly_prediction_widget.dart';
import 'package:bazi_app_frontend/widgets/today_hora_chart_widget.dart';
import 'package:bazi_app_frontend/widgets/forecast_widget.dart';
import 'package:bazi_app_frontend/widgets/luck_calendar_widget.dart';
import 'package:bazi_app_frontend/widgets/authenticated_screen/edit_info_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   formatThaiDate(DateTime.now()),
                    //   style: Theme.of(context).textTheme.bodySmall,
                    // ),
                    Row(
                      children: [
                        Text(
                          "สวัสดี! คุณ ${widget.userData.name}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Positioned(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditInfoScreen(oldData: widget.userData),
                                ),
                              );
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.edit, color: Colors.black, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          child: colorDisplaying[colorName] ??
                              const SizedBox(),
                        ),
                      )
                      .toList()),
              ],
            ),
            const SizedBox(height: 30),
            // ForecastTabs(horaRepository: HoraRepository(),)
          ],
        ),
      ),
    );
  }
}