import 'package:flutter/material.dart';
import 'package:bazi_app_frontend/configs/theme.dart';

class ForecastTabs extends StatefulWidget {
  final Map<String, dynamic> todayHora;
  const ForecastTabs({super.key, required this.todayHora});

  @override
  State<ForecastTabs> createState() => _ForecastTabsState();
}

class _ForecastTabsState extends State<ForecastTabs>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildPredictionTab(String key) {
    final text = widget.todayHora["monthlyPrediction"]?[key];
    if (text == null) {
      return const Center(
        child: Text("กำลังโหลด...", style: TextStyle(color: Colors.white)),
      );
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: wColor),
          ),
        ),
      );
    }
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
        const SizedBox(height: 10),
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
                  width: 84.5,
                  height: 40,
                  margin: const EdgeInsets.only(right: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? Theme.of(context).primaryColor : wColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    border: Border.all(
                      color:
                          selected ? Theme.of(context).primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    tabTitles[index],
                    style: TextStyle(
                      color: selected ? wColor : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(
          height: 190,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: currentIndex == 0 ? Radius.zero : const Radius.circular(10),
                topRight: currentIndex == 3 ? Radius.zero : const Radius.circular(10),
                bottomLeft: const Radius.circular(10),
                bottomRight: const Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildPredictionTab("health"),
                buildPredictionTab("love"),
                buildPredictionTab("money"),
                buildPredictionTab("work"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}