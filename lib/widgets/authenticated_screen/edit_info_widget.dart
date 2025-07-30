import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/screens/member_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/user_model.dart';
import '../../repositories/userdata_repository.dart';
import '../gender_selector_widget.dart';

class EditInfoWidget extends StatefulWidget {

  final UserModel oldData;

  const EditInfoWidget({required this.oldData, super.key});

  @override
  State<EditInfoWidget> createState() => _EditInfoWidgetState();
}

class _EditInfoWidgetState extends State<EditInfoWidget> {
  late int selectedGender;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    selectedGender = widget.oldData.gender;
    nameController.text = widget.oldData.name;
    dateController.text = widget.oldData.birthDate.split(" ")[0];
    timeController.text = widget.oldData.birthDate.split(" ")[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: wColor,
            backgroundColor: Theme.of(context).primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MemberScreen(),
                  ),
                );
              },
            ),
            title: const Text("แก้ไขข้อมูลส่วนตัว")),
        body: Stack(children: [
          Opacity(
              opacity: 0.5,
              child: Positioned.fill(
                child: Image.asset('assets/images/edit_background.jpg',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/welcome_pic.png'),
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: wColor, borderRadius: BorderRadius.circular(9)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (Column(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextField(
                            cursorColor: Theme.of(context).focusColor,
                            decoration: const InputDecoration(
                              labelText: "ชื่อ",
                            ),
                            controller: nameController,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now());
                                if (pickedDate != null &&
                                    pickedDate != DateTime.now()) {
                                  setState(() {
                                    dateController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    debugPrint(dateController.text);
                                  });
                                }
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                  controller: dateController,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: "เลือกวันเกิด"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final TimeOfDay? timePicked =
                                    await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        builder: (context, child) {
                                          return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      alwaysUse24HourFormat:
                                                          true),
                                              child: child!);
                                        });
                                if (timePicked != null &&
                                    timePicked != TimeOfDay.now()) {
                                  setState(() {
                                    timeController.text =
                                        "${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}:00";
                                  });
                                }
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("เพศ: "),
                            const SizedBox(
                              width: 10,
                            ),
                            GenderSelectorWidget(
                              onGenderSelected: (gender) {
                                setState(() {
                                  selectedGender = gender;
                                });
                              },
                            ),
                          ],
                        ),
                      ])),
                    )),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () async {
                      if (nameController.text.isEmpty ||
                          dateController.text.isEmpty ||
                          timeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("กรุณากรอกข้อมูลให้ครบถ้วน")));
                        return;
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MemberScreen(),
                        ),
                      );
                      await UserDataRepository().registerUser(
                          nameController.text,
                          dateController.text,
                          timeController.text,
                          selectedGender);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                        "บันทึกการแก้ไข",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: wColor),
                      )),
                    ))
              ],
            ),
          )
        ]));
  }
}
