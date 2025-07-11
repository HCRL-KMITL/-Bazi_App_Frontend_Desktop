import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/repositories/authentication_repository.dart';
import 'package:bazi_app_frontend/repositories/userdata_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/gender_selector_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key, required this.onRegistrationComplete});

  final VoidCallback onRegistrationComplete;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  int selectedGender = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository().signOut(),
            icon: const Icon(Icons.logout),
            color: wColor,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ลงทะเบียนผู้ใช้ใหม่',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
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
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());
                    if (pickedDate != null && pickedDate != DateTime.now()) {
                      setState(() {
                        dateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        debugPrint(dateController.text);
                      });
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: dateController,
                      enabled: false,
                      decoration:
                          const InputDecoration(labelText: "เลือกวันเกิด"),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final TimeOfDay? timePicked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (context, child) {
                          return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!);
                        });
                    if (timePicked != null && timePicked != TimeOfDay.now()) {
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
                      decoration:
                          const InputDecoration(labelText: "เลือกเวลาเกิด"),
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
                setState(() {
                  selectedGender = gender;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  if (nameController.text.isEmpty ||
                      dateController.text.isEmpty ||
                      timeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("กรุณากรอกข้อมูลให้ครบถ้วน")));
                    return;
                  }
                  debugPrint(
                      "Name: ${nameController.text}, Date: ${dateController.text}, Time: ${timeController.text}, Gender: $selectedGender");
                  UserDataRepository().registerUser(
                      nameController.text,
                      dateController.text,
                      timeController.text,
                      selectedGender);
                  widget.onRegistrationComplete();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                    "ลงทะเบียน",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: wColor),
                  )),
                ))
          ],
        ),
      ),
    );
  }
}
