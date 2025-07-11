import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/userdata_repository.dart';
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
  // User Data
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

  int bottomNavIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> widgetOptions = {
      0: userData != null
          ? HomeWidget(
              userData: userData!,
            )
          : loadingWidget(),
      1: const CalendarWidget(),
      2: userData != null
          ? ProfileWidget(
              userData: userData!,
            )
          : loadingWidget(),
    };
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: widgetOptions[bottomNavIndex]!,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BottomNavigationBar(
              currentIndex: bottomNavIndex,
              onTap: onItemTapped,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: wColor,
              unselectedItemColor: Theme.of(context).disabledColor,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'หน้าหลัก',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'ปฏิทินวันดี',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'ข้อมูลส่วนตัว',
                ),
              ]),
        ));
  }
}
