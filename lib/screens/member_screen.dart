import 'dart:math';

import 'package:bazi_app_frontend/constants/constants.dart';
import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/hora_repository.dart';
import 'package:bazi_app_frontend/repositories/userdata_repository.dart';
import 'package:bazi_app_frontend/screens/guesthora_screen.dart';
import 'package:bazi_app_frontend/widgets/TodayHoraSection.dart';
import 'package:bazi_app_frontend/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/widgets/authenticated_screen/authenticated_screen_widgets.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  UserModel? userData;
  Map<String, dynamic> todayHora = {};
  List<String?> bestTime = [];

  Future<void> getUserData() async {
    UserModel user = await UserDataRepository().getUserData();
    setState(() {
      userData = user;
    });
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

  @override
  void initState() {
    super.initState();
    getUserData();
    getDailyHora();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: userData != null
          ? Padding(
              padding: const EdgeInsets.only(right: 25, left: 25, bottom: 25),
              child: SizedBox.expand(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: HomeWidget(userData: userData!),
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CalendarWidget(),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: TodayHoraSection(
                                todayHora: todayHora,
                                bestTime: bestTime,
                              ),
                            ),
                          ],
                        ),
                        )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: GuestHoraScreen(
                          name: userData!.name,
                          birthDate: userData!.birthDate.split(" ")[0],
                          birthTime: userData!.birthDate.split(" ")[1],
                          gender: userData!.gender,
                        ),
                      )
                    ),
                  ],
                ),
              ),
            )
          : loadingWidget(),
    );
  }
}