// HANDLE DATE DISPLAYING \\
import 'package:flutter/material.dart';

Map<String, String> thaiMonth = {
  "01": "มกราคม",
  "02": "กุมภาพันธ์",
  "03": "มีนาคม",
  "04": "เมษายน",
  "05": "พฤษภาคม",
  "06": "มิถุนายน",
  "07": "กรกฎาคม",
  "08": "สิงหาคม",
  "09": "กันยายน",
  "10": "ตุลาคม",
  "11": "พฤศจิกายน",
  "12": "ธันวาคม"
};

// HANDLE THAI ELEMENT DISPLAYING \\
Map<String, String> thaiElement = {
  "Wood": "ไม้",
  "Fire": "ไฟ",
  "Earth": "ดิน",
  "Metal": "ทอง",
  "Water": "น้ำ"
};

Map<String, String> thaiYinyang = {
  "Yin": "หยิน (-)",
  "Yang": "หยาง (+)",
};

// HANDLE YAM \\
Map<int, String> yam = {
  1: "0:19-1:18",
  2: "1:19-3:18",
  3: "3:19-5:18",
  4: "5:19-7:18",
  5: "7:19-9:18",
  6: "9:19-11:18",
  7: "11:19-13:18",
  8: "13:19-15:18",
  9: "15:19-17:18",
  10: "17:19-19:18",
  11: "19:19-21:18",
  12: "21:19-23:18",
};

// HANDLE Color Displaying \\
Widget colorDisplayContainer(Color color) {
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
  );
}

Map<String, Widget> colorDisplaying = {
  "Red": colorDisplayContainer(Colors.red),
  "Green": colorDisplayContainer(Colors.green),
  "Yellow": colorDisplayContainer(Colors.yellow),
  "Blue": colorDisplayContainer(Colors.blue),
  "Cyan": colorDisplayContainer(Colors.cyan),
  "Purple": colorDisplayContainer(Colors.purple),
  "Orange": colorDisplayContainer(Colors.orange),
  "Pink": colorDisplayContainer(Colors.pink),
  "Brown": colorDisplayContainer(Colors.brown),
  "Grey": colorDisplayContainer(Colors.grey),
  "Gold": colorDisplayContainer(Colors.amber),
  "Black": colorDisplayContainer(Colors.black),
  "White": colorDisplayContainer(Colors.white),
};
