import 'package:bazi_app_frontend/repositories/authentication_repository.dart';
import 'package:bazi_app_frontend/screens/guesthora_screen.dart';
import 'package:bazi_app_frontend/widgets/gender_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/grommet_icons.dart';
import 'package:intl/intl.dart';

import '../configs/theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  int selectedGender = 0; //0 = Male, 1 = Female

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/wallpaper.png',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'BAZI',
                    style: TextStyle(
                      fontFamily: 'CinzelDecorative',
                      fontSize: 70,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 7.0,
                      shadows: [
                        Shadow(
                          offset: Offset(3, 3),     
                          blurRadius: 6.0,          
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.15),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'APP',
                      style: TextStyle(
                        fontFamily: 'CinzelDecorative',
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: [
                        Shadow(
                          offset: Offset(3, 3),     
                          blurRadius: 6.0,          
                          color: Colors.black45,
                        ),
                      ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint("Sign in with Google");
                    AuthenticationRepository().signInWithGoogle();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: wColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Iconify(GrommetIcons.google),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("ลงชื่อเข้าใช้ด้วย Google",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    height: screenHeight * 0.02,
                ),
                GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        int selectedGender = 0;
                        return StatefulBuilder(
                          builder: (context, setDialogState) {
                            return AlertDialog(
                              title: Center(
                                  child: Text(
                                "ใส่ข้อมูลของท่าน",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: TextField(
                                      cursorColor: Theme.of(context).focusColor,
                                      decoration: const InputDecoration(
                                        labelText: "ชื่อ",
                                      ),
                                      controller: nameController,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    spacing: 10,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                            builder: (BuildContext dialogContext, Widget? child) {
                                              return Theme(
                                                data: Theme.of(dialogContext).copyWith(
                                                  colorScheme: const ColorScheme.light(
                                                    primary: Color.fromARGB(255, 45, 66, 98),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );
                                          if (pickedDate != null && pickedDate != DateTime.now()) {
                                            setState(() {
                                              dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                              debugPrint(dateController.text);
                                            });
                                          }
                                        },
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.3,
                                          child: TextField(
                                            controller: dateController,
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              labelText: "เลือกวันเกิด",
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final TimeOfDay? timePicked = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            builder: (context, child) {
                                              return Theme(
                                                data: Theme.of(context).copyWith(
                                                  colorScheme: const ColorScheme.light(
                                                    primary: Color.fromARGB(255, 45, 66, 98),                
                                                  ),
                                                  timePickerTheme: const TimePickerThemeData(
                                                    backgroundColor: Colors.white,                 
                                                  ),
                                                ),
                                                child: MediaQuery(
                                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  child: child!,
                                                ),
                                              );
                                            },
                                          );

                                          if (timePicked != null) {
                                            setState(() {
                                              timeController.text =
                                                  "${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}:00";
                                            });
                                          }
                                        },

                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: TextField(
                                            controller: timeController,
                                            enabled: false,
                                            decoration: const InputDecoration(
                                                labelText: "เลือกเวลาเกิด"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  GenderSelectorWidget(
                                    onGenderSelected: (gender) {
                                      setDialogState(() {
                                        selectedGender = gender;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        if (nameController.text.isEmpty ||
                                            dateController.text.isEmpty ||
                                            timeController.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "กรุณากรอกข้อมูลให้ครบถ้วน")));
                                          return;
                                        }
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GuestHoraScreen(
                                                      name: nameController.text,
                                                      birthDate:
                                                          dateController.text,
                                                      birthTime:
                                                          timeController.text,
                                                      gender: selectedGender,
                                                    )));
                                        
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                            child: Text(
                                          "วิเคราะห์พื้นดวง",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: wColor),
                                        )),
                                      ))
                                ],
                              ),
                            );
                          },
                        );
                      }),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: wColor),
                    child: Center(
                        child: Text(
                      "ผู้เยี่ยมชม",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
  }
}
