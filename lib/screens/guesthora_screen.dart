import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/bazichart_model.dart';
import 'package:bazi_app_frontend/repositories/authentication_repository.dart';
import 'package:bazi_app_frontend/repositories/fourpillars_repository.dart';
import 'package:bazi_app_frontend/repositories/hora_repository.dart';
import 'package:bazi_app_frontend/repositories/misc_repository.dart';
import 'package:bazi_app_frontend/screens/member_screen.dart';
import 'package:bazi_app_frontend/screens/welcome_screen.dart';
import 'package:bazi_app_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

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
  final PageController _pageController = PageController();

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
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   foregroundColor: wColor,
      //   elevation: 15,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () {
      //       if (args?['from'] == 'member') {
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => const MemberScreen(),
      //             ));
      //       } else {
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => const WelcomeScreen(),
      //             ));
      //       }
      //     },
      //   ),
      //   title: const Text("Bazi Chart"),
      // ),
      body: FutureBuilder<BaziChart>(
        future: futureBaziChart,
        builder: (context, snapshot) {
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
            BaziChart baziChart = snapshot.data!;
            String element = baziChart.dayPillar.heavenlyStem.name;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
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
                  ]
                ),
                FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                    front: Column(
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Text("ผลการทำนาย",
                              style: Theme.of(context).textTheme.headlineMedium),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.67,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  'assets/images/new_fream.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 130),
                                    personalElementText(context, element),
                                    FourPillarTable(chart: baziChart),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    back: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          Center(
                            child: Text("ผลการทำนาย",
                                style: Theme.of(context).textTheme.headlineMedium),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.67,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.asset(
                                    'assets/images/new_fream.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsetsGeometry.only(left: 30, right: 30, top: 100),
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Text("คำทำนาย",
                                        //     style: Theme.of(context).textTheme.headlineMedium),
                                        // Text(
                                        //     "${MiscRepository().displayThaiDate(widget.birthDate)} ${widget.birthTime.substring(0, 5)} น.",
                                        //     style: Theme.of(context).textTheme.bodyLargeRed),
                                        const SizedBox(height: 20),
                                        _buildPredictionBlock(
                                          context,
                                          icon: Icons.accessibility,
                                          title: "ลักษณะนิสัย",
                                          text: HoraRepository()
                                              .getBaseHora(element)[element]["pros"],
                                        ),
                                        const SizedBox(height: 20),
                                        _buildPredictionBlock(
                                          context,
                                          icon: Icons.thumb_down,
                                          title: "ข้อเสีย",
                                          text: HoraRepository()
                                              .getBaseHora(element)[element]["cons"],
                                        ),
                                        const SizedBox(height: 20),
                                        _buildPredictionBlock(
                                          context,
                                          icon: Icons.badge,
                                          title: "อาชีพที่เหมาะสม",
                                          text: HoraRepository()
                                              .getBaseHora(element)["occupation"],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ),
                )
              ]
            );
          }
        },
      ),
    );
  }
}

Widget _buildPredictionBlock(BuildContext context,
    {required IconData icon, required String title, required String text}) {
  return Container(
    // ignore: deprecated_member_use
    color: wColor.withOpacity(0.8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}

String _shortenName(String name, {int maxLength = 25}) {
  if (name.length <= maxLength) {
    return name;
  } else {
    return '${name.substring(0, maxLength)}...';
  }
}
