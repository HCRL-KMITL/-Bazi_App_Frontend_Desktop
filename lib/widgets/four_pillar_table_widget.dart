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
        const SizedBox(height: 20,),
        SizedBox(
          width: 120,
          height: 120,
          child: pillarCell(
            chart.dayPillar.heavenlyStem,
            fontSizeCharacter: 50,
            fontSizeSpelling: 20,
          ),
        ),
        const SizedBox(height: 20,),
        Table(
          columnWidths: const <int, TableColumnWidth>{
          },
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Padding (
                  padding: const EdgeInsetsGeometry.fromLTRB(15, 0, 0, 0),
                    child: pillarCell(chart.hourPillar.heavenlyStem),
                  ),),
                TableCell(
                  child: pillarCell(chart.dayPillar.heavenlyStem),
                ),
                TableCell(
                  child: pillarCell(chart.monthPillar.heavenlyStem),
                ),
                TableCell(
                  child: Padding (
                  padding: const EdgeInsetsGeometry.fromLTRB(0, 0, 15, 0),
                    child: pillarCell(chart.yearPillar.heavenlyStem),
                  ),),
              ],
            ),
            const TableRow(
              children: [
                TableCell(child: SizedBox(height: 15)),
                TableCell(child: SizedBox(height: 15)),
                TableCell(child: SizedBox(height: 15)),
                TableCell(child: SizedBox(height: 15)),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding (
                  padding: const EdgeInsetsGeometry.fromLTRB(15, 0, 0, 0),
                    child: pillarCell(chart.hourPillar.earthlyBranch),
                  ),),
                TableCell(
                  child: pillarCell(chart.dayPillar.earthlyBranch),
                ),
                TableCell(
                  child: pillarCell(chart.monthPillar.earthlyBranch),
                ),
                TableCell(
                  child: Padding (
                  padding: const EdgeInsetsGeometry.fromLTRB(0, 0, 15, 0),
                    child: pillarCell(chart.yearPillar.earthlyBranch),
                  ),),
              ],
            ),
          ],
        ),
      ],
    );
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
      Color.fromARGB(182, 90, 163, 202)];
  } else if (['fire', 'snake', 'horse'].contains(e)) {
    return const [
      Color.fromARGB(255, 81, 8, 8),
      Color.fromARGB(182, 191, 49, 49)];
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
      Color.fromARGB(182, 182, 181, 181)];
  } else {
    return [Colors.black];
  }
}

Widget pillarCell(
  Branch branch, {
  double fontSizeCharacter = 30,
  double fontSizeSpelling = 16,
}) {
  return Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
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
