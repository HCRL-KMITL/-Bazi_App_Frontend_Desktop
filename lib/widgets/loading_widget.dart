import 'package:flutter/material.dart';

Widget loadingWidget() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(
          height: 10,
        ),
        Text("กำลังโหลดข้อมูล...")
      ],
    ),
  );
}
