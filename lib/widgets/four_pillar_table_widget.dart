import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/bazichart_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/fourpillars_model.dart';

class FourPillarTable extends StatelessWidget {
  const FourPillarTable({required this.chart, super.key});

  final BaziChart chart;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 120,
          height: 120,
          child: pillarCell(chart.dayPillar.heavenlyStem,
              fontSizeCharacter: 40, fontSizeSpelling: 20, isCircle: true),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0), // padding ซ้ายขวา
          child: Table(
            border: TableBorder.all(
              color: Colors.grey,
              width: 1,
            ),
            columnWidths: const <int, TableColumnWidth>{},
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                children: [
                  for (final label in ["Hour", "Day", "Month", "Year"])
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Center(
                          child: Text(label,
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ),
                    ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                        child: pillarCell(chart.hourPillar.heavenlyStem)),
                  ),
                  TableCell(
                      child: Center(
                          child: pillarCell(chart.dayPillar.heavenlyStem))),
                  TableCell(
                      child: Center(
                          child: pillarCell(chart.monthPillar.heavenlyStem))),
                  TableCell(
                    child: Center(
                        child: pillarCell(chart.yearPillar.heavenlyStem)),
                  ),
                ],
              ),
              const TableRow(
                children: [
                  TableCell(child: SizedBox(height: 5)),
                  TableCell(child: SizedBox(height: 5)),
                  TableCell(child: SizedBox(height: 5)),
                  TableCell(child: SizedBox(height: 5)),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                        child: pillarCell(chart.hourPillar.earthlyBranch)),
                  ),
                  TableCell(
                      child: Center(
                          child: pillarCell(chart.dayPillar.earthlyBranch))),
                  TableCell(
                      child: Center(
                          child: pillarCell(chart.monthPillar.earthlyBranch))),
                  TableCell(
                    child: Center(
                        child: pillarCell(chart.yearPillar.earthlyBranch)),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

String getElementName(String element) {
  String e = element.toLowerCase();

  if (e.contains(' ')) {
    e = e.split(' ')[1];
  }

  if (['water', 'rat', 'pig'].contains(e)) {
    return 'Water';
  } else if (['fire', 'snake', 'horse'].contains(e)) {
    return 'Fire';
  } else if (['wood', 'tiger', 'rabbit'].contains(e)) {
    return 'Wood';
  } else if (['earth', 'ox', 'dragon', 'goat', 'dog'].contains(e)) {
    return 'Earth';
  } else if (['metal', 'monkey', 'rooster'].contains(e)) {
    return 'Metal';
  } else {
    return 'Unknown';
  }
}

List<Color> elementColor(String element) {
  String e = element.toLowerCase();

  if (e.contains(' ')) {
    e = e.split(' ')[1];
  }

  if (['water', 'rat', 'pig'].contains(e)) {
    return const [
      Color.fromARGB(255, 13, 45, 73),
      Color.fromARGB(182, 90, 163, 202)
    ];
  } else if (['fire', 'snake', 'horse'].contains(e)) {
    return const [
      Color.fromARGB(255, 81, 8, 8),
      Color.fromARGB(182, 191, 49, 49)
    ];
  } else if (['wood', 'tiger', 'rabbit'].contains(e)) {
    return const [
      Color.fromARGB(255, 35, 69, 46),
      Color.fromARGB(182, 94, 147, 108)
    ];
  } else if (['earth', 'ox', 'dragon', 'goat', 'dog'].contains(e)) {
    return const [
      Color.fromARGB(255, 127, 60, 29),
      Color.fromARGB(182, 254, 119, 67)
    ];
  } else if (['metal', 'monkey', 'rooster'].contains(e)) {
    return const [
      Color.fromARGB(255, 80, 74, 65),
      Color.fromARGB(182, 182, 181, 181)
    ];
  } else {
    return [Colors.black];
  }
}

Widget pillarCell(
  Branch branch, {
  double fontSizeCharacter = 20,
  double fontSizeSpelling = 13,
  bool isCircle = false, // เพิ่มพารามิเตอร์กำหนดรูปร่าง
}) {
  return Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      gradient: RadialGradient(
        colors: [
          ...elementColor(branch.name),
        ],
      ),
    ),
    padding: const EdgeInsets.all(5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          getElementName(branch.name),
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              fontSize: 13,
              color: wColor,
            ),
          ),
        ),
        Text(
          branch.character,
          style: TextStyle(
            fontFamily: 'ChironSungHK',
            fontSize: fontSizeCharacter,
            fontWeight: FontWeight.w900,
            color: wColor,
          ),
        ),
        Text(
          branch.spelling,
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              fontSize: fontSizeSpelling,
              color: wColor,
            ),
          ),
        ),
      ],
    ),
  );
}
