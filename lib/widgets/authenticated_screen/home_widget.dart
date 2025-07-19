import 'dart:math';

import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/constants/constants.dart';
import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/authentication_repository.dart';
import 'package:bazi_app_frontend/repositories/hora_repository.dart';
import 'package:bazi_app_frontend/widgets/monthly_prediction_widget.dart';
import 'package:bazi_app_frontend/widgets/today_hora_chart_widget.dart';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uiw.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({required this.userData, super.key});

  final UserModel userData;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
    if (!mounted) return; // ป้องกัน setState หลัง dispose
    setState(() {
      todayHora = horaToday;
      bestTime = bestTimeIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                  Text(
                    "สวัสดี! คุณ ${widget.userData.name}",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
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
                      icon: const Icon(Icons.logout)),
                ],
              ),
              const SizedBox(height: 15),
              Center(
                child: Text("คะแนนประจำวันของคุณ",
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  child: todayHora.isEmpty
                      ? const Center(child: Text("กำลังโหลด..."))
                      : TodayHoraChart(h: todayHora["hours"]),
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                    const TextSpan(
                        text: "ช่วงเวลาที่ดีที่สุดสำหรับคุณในวันนี้คือ "),
                    TextSpan(
                        text: bestTime.join(", "),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ])),
              const SizedBox(height: 15),
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
              const SizedBox(height: 20),
              Text("พยากรณ์ประจำเดือน",
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              Text(
                "สุขภาพ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              MonthlyPredictionWidget(
                  predText: todayHora["monthlyPrediction"]?["health"] ??
                      "กำลังโหลด..."),
              Text(
                "ความรัก",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              MonthlyPredictionWidget(
                  predText: todayHora["monthlyPrediction"]?["love"] ??
                      "กำลังโหลด..."),
              Text(
                "การเงิน",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              MonthlyPredictionWidget(
                  predText: todayHora["monthlyPrediction"]?["money"] ??
                      "กำลังโหลด..."),
              Text(
                "การงาน",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              MonthlyPredictionWidget(
                  predText: todayHora["monthlyPrediction"]?["work"] ??
                      "กำลังโหลด..."),
            ],
          ),
        ),
      ),
    );
  }
}
