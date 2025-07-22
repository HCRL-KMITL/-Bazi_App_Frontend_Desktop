import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/misc_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../repositories/hora_repository.dart';
import '../widgets.dart';
import 'edit_info_widget.dart';

class ProfileWidget extends StatefulWidget {
  final UserModel userData;

  const ProfileWidget({required this.userData, super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 3),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          currentUser!.photoURL!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text("ข้อมูลส่วนตัว",
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.userData.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    widget.userData.gender == 0 ? Icons.male : Icons.female,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.userData.email,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).primaryColor),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                height: 350,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Row(children: [
                      Icon(Icons.calendar_today),
                      Text(
                          "${MiscRepository().displayThaiDate(widget.userData.birthDate.split(" ")[0])}, ${widget.userData.birthDate.split(" ")[1].substring(0, 5)} น.",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ]),
                    Text(
                      "การทำนายด้วยศาสตร์ บาจื้อ",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
