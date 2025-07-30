import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/userdata_repository.dart';
import 'package:bazi_app_frontend/screens/guesthora_screen.dart';
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

  Future<void> getUserData() async {
    UserModel user = await UserDataRepository().getUserData();
    setState(() {
      userData = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: userData != null
    ? Padding(
        padding: const EdgeInsets.only(right: 25, left: 25, bottom: 25),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: HomeWidget(userData: userData!),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(top: 150),
                child: GuestHoraScreen(
                  name: userData!.name,
                  birthDate: userData!.birthDate.split(" ")[0],
                  birthTime: userData!.birthDate.split(" ")[1],
                  gender: userData!.gender,
                ),
              )
            ),
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 25),
                child: CalendarWidget(),
              )
            ),
          ],
        )
      )
    : loadingWidget(),
    );
  }
}
