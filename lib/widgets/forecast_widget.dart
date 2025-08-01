import 'package:bazi_app_frontend/repositories/hora_repository.dart';
import 'package:flutter/material.dart';
import 'package:bazi_app_frontend/configs/theme.dart';

class ForecastTabs extends StatefulWidget {
  final HoraRepository horaRepository;
  const ForecastTabs({super.key, required this.horaRepository});

  @override
  State<ForecastTabs> createState() => _ForecastTabsState();
}

class _ForecastTabsState extends State<ForecastTabs>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Future<Map<String, dynamic>> _horaFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _horaFuture = widget.horaRepository.getDailyHora();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildPredictionTab(Map<String, dynamic> todayHora, String key) {
    //print("Building tab for ${ widget.todayHora["hora"]}");
    final text = todayHora["hora"]?[key] ?? "ไม่มีข้อมูล";

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          text,
          style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(color: wColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabTitles = ["สุขภาพ", "ความรัก", "การเงิน", "การงาน"];
    final int currentIndex = _tabController.index;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("พยากรณ์ประจำเดือน",
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 30),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(4, (index) {
              final bool selected = currentIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _tabController.index = index;
                  });
                },
                child: Container(
                  width: 137.5,
                  height: 50,
                  margin: const EdgeInsets.only(right: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).primaryColor
                        : const Color.fromARGB(255, 243, 197, 203),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    border: Border.all(
                      color: selected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    tabTitles[index],
                    style: TextStyle(
                      color: selected ? wColor : Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(
            height: 600,
            child: FutureBuilder(
                future: _horaFuture,
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (asyncSnapshot.hasError) {
                    return Center(
                      child: Text(
                        "เกิดข้อผิดพลาด: ${asyncSnapshot.error}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: wColor),
                      ),
                    );
                  }
                  if (asyncSnapshot.hasData) {
                    final todayHora = asyncSnapshot.data!;
                    return Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 244, 174, 174),
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: currentIndex == 0
                                ? Radius.zero
                                : const Radius.circular(10),
                            topRight: currentIndex == 3
                                ? Radius.zero
                                : const Radius.circular(10),
                            bottomLeft: const Radius.circular(10),
                            bottomRight: const Radius.circular(10),
                          ),
                        ),
                        padding: const EdgeInsets.all(25),
                        child: TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            buildPredictionTab(todayHora, "health"),
                            buildPredictionTab(todayHora, "love"),
                            buildPredictionTab(todayHora, "money"),
                            buildPredictionTab(todayHora, "work"),
                          ],
                        ),
                      ),
                    ],
                  );
                  }
                  return const Center(
                    child: Text(
                      "ไม่มีข้อมูล",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                )
              ),
      ],
    );
  }
}
