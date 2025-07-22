import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/bazichart_model.dart';
import 'package:bazi_app_frontend/repositories/fourpillars_repository.dart';
import 'package:bazi_app_frontend/repositories/hora_repository.dart';
import 'package:bazi_app_frontend/repositories/misc_repository.dart';
import 'package:bazi_app_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GuestHoraScreen extends StatefulWidget {
  const GuestHoraScreen(
      {required this.name,
      required this.birthDate,
      required this.birthTime,
      required this.gender,
      super.key});
  final String name;
  final String birthDate;
  final String birthTime;
  final int gender;

  @override
  _GuestHoraScreenState createState() => _GuestHoraScreenState();
}

class _GuestHoraScreenState extends State<GuestHoraScreen> {
  late Future<BaziChart> futureBaziChart;

  @override
  void initState() {
    super.initState();
    futureBaziChart = getFourPillars();
  }

  Future<BaziChart> getFourPillars() async {
    return await FourPillarsRepository().getFourPillars(
        "${widget.birthDate} ${widget.birthTime}", widget.gender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: wColor,
        elevation: 15,
        shadowColor: const Color.fromARGB(255, 221, 52, 40),
        title: const Text("Bazi Chart"),
      ),
      body: FutureBuilder<BaziChart>(
        future: futureBaziChart, // Future to fetch BaziChart
        builder: (context, snapshot) {
          // Check the connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: fcolor),
                const SizedBox(height: 10),
                Text("กำลังดึงข้อมูล... กรุณารอสักครู่",
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Text('No data found');
          } else {
            // Display the Bazi chart data
            BaziChart baziChart = snapshot.data!;
            String element = baziChart.dayPillar.heavenlyStem.name;
            return SingleChildScrollView(
              child: Center(
                // padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "ผลการทำนาย",
                        style: Theme.of(context).textTheme.headlineMediumRed,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // เพื่อไม่ให้เต็มพื้นที่แนวตั้ง
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.gender == 0 ? Icons.male : Icons.female,
                                size: 40,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                _shortenName(widget.name),
                                style: Theme.of(context).textTheme.bodyLargeRed,
                                softWrap: true,
                              ),
                            ],
                          ),
                          Text(
                            "${MiscRepository().displayThaiDate(widget.birthDate)} ${widget.birthTime.substring(0, 5)} น.",
                            style: Theme.of(context).textTheme.bodyLargeRed,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/fream.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                         Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 130),
                                SizedBox(
                                  child: personalElementText(context, element),
                                ),
                                FourPillarTable(chart: baziChart),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.accessibility,
                                color: wColor,
                              ),
                              const SizedBox(width: 8), 
                              Text(
                                "ลักษณะนิสัย",
                                style: Theme.of(context).textTheme.headlineSmallW,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            HoraRepository().getBaseHora(element)[element]["pros"],
                            style: const TextStyle(color: wColor),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(
                                Icons.thumb_down,
                                color: wColor,
                              ),
                              const SizedBox(width: 8), 
                              Text(
                                "ข้อเสีย",
                                style: Theme.of(context).textTheme.headlineSmallW,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            HoraRepository().getBaseHora(element)[element]["cons"],
                            style: const TextStyle(color: wColor),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(
                                Icons.badge,
                                color: wColor,
                              ),
                              const SizedBox(width: 8), 
                              Text(
                                "อาชีพที่เหมาะสม",
                                style: Theme.of(context).textTheme.headlineSmallW,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            HoraRepository().getBaseHora(element)["occupation"],
                            style: const TextStyle(color: wColor),
                          ),
                        ],
                      ),
                    ),

                    // Center(
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width * 0.75,
                    //     height: 45,
                    //     decoration: BoxDecoration(
                    //       color: fcolor,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         "กรุณาเข้าสู่ระบบเพื่อดูข้อมูลเพิ่มเติม",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyMedium!
                    //             .copyWith(color: wColor),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
  
String _shortenName(String name, {int maxLength = 25}) {
  if (name.length <= maxLength) {
    return name;
  } else {
    return '${name.substring(0, maxLength)}...';
  }
}