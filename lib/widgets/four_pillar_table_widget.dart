import 'package:bazi_app_frontend/models/bazichart_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/fourpillars_model.dart';

class FourPillarTable extends StatelessWidget {
  const FourPillarTable({required this.chart, super.key});

  final BaziChart chart;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            TableCell(
              child: pillarCell(chart.hourPillar.heavenlyStem),
            ),
            TableCell(
              child: pillarCell(chart.dayPillar.heavenlyStem),
            ),
            TableCell(
              child: pillarCell(chart.monthPillar.heavenlyStem),
            ),
            TableCell(
              child: pillarCell(chart.yearPillar.heavenlyStem),
            ),
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
              child: pillarCell(chart.hourPillar.earthlyBranch),
            ),
            TableCell(
              child: pillarCell(chart.dayPillar.earthlyBranch),
            ),
            TableCell(
              child: pillarCell(chart.monthPillar.earthlyBranch),
            ),
            TableCell(
              child: pillarCell(chart.yearPillar.earthlyBranch),
            ),
          ],
        ),
      ],
    );
  }
}

Color elementColor(String element) {
  String e = element.toLowerCase();

  if (e.contains(' ')) {
    e = e.split(' ')[1];
  }

  if (['water', 'rat', 'pig'].contains(e)) {
    return const Color.fromRGBO(74, 144, 226, 0.5);
  } else if (['fire', 'snake', 'horse'].contains(e)) {
    return const Color.fromRGBO(226, 92, 92, 0.5);
  } else if (['wood', 'tiger', 'rabbit'].contains(e)) {
    return const Color.fromRGBO(122, 188, 10, 0.5);
  } else if (['earth', 'ox', 'dragon', 'goat', 'dog'].contains(e)) {
    return const Color.fromRGBO(184, 149, 10, 0.5);
  } else if (['metal', 'monkey', 'rooster'].contains(e)) {
    return Colors.grey.shade400;
  } else {
    return Colors.black;
  }
}

Widget pillarCell(Branch branch) {
  return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: elementColor(branch.name),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(branch.character,
              style: GoogleFonts.kanit(
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Text(
            branch.spelling,
            style: GoogleFonts.kanit(
              textStyle: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ));
}
