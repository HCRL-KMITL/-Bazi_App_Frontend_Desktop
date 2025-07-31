import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/userdata_repository.dart';
import 'package:bazi_app_frontend/screens/member_screen.dart';
import 'package:bazi_app_frontend/widgets/gender_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditInfoScreen extends StatefulWidget {
  final UserModel oldData;

  const EditInfoScreen({required this.oldData, super.key});

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  late int selectedGender;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedGender = widget.oldData.gender;
    nameController.text = widget.oldData.name;
    dateController.text = widget.oldData.birthDate.split(" ")[0];
    timeController.text = widget.oldData.birthDate.split(" ")[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/edit_background.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ภาพ welcome
                  Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/welcome_pic.png'),
                      ),
                    ),
                  ),

                  // กล่องกรอกข้อมูล
                  Container(
                    decoration: BoxDecoration(
                      color: wColor,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4 + 20,
                            child: TextField(
                              cursorColor: Theme.of(context).focusColor,
                              decoration: const InputDecoration(labelText: "ชื่อ"),
                              controller: nameController,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // เลือกวันเกิด
                              GestureDetector(
                                onTap: () async {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      dateController.text =
                                          DateFormat('yyyy-MM-dd').format(pickedDate);
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: TextField(
                                    controller: dateController,
                                    enabled: false,
                                    decoration: const InputDecoration(labelText: "เลือกวันเกิด"),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 30,),

                              // เลือกเวลาเกิด
                              GestureDetector(
                                onTap: () async {
                                  final timePicked = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(alwaysUse24HourFormat: true),
                                        child: child!,
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
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: TextField(
                                    controller: timeController,
                                    enabled: false,
                                    decoration: const InputDecoration(labelText: "เลือกเวลาเกิด"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("เพศ: "),
                              const SizedBox(width: 10),
                              GenderSelectorWidget(
                                onGenderSelected: (gender) {
                                  setState(() {
                                    selectedGender = gender;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ปุ่มบันทึก
                  GestureDetector(
                    onTap: () async {
                      if (nameController.text.isEmpty ||
                          dateController.text.isEmpty ||
                          timeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("กรุณากรอกข้อมูลให้ครบถ้วน")),
                        );
                        return;
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MemberScreen()),
                      );

                      await UserDataRepository().registerUser(
                        nameController.text,
                        dateController.text,
                        timeController.text,
                        selectedGender,
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "บันทึกการแก้ไข",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: wColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
