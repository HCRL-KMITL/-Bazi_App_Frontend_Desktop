import 'package:bazi_app_frontend/constants/constants.dart';
import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:flutter/material.dart';

Widget personalElementText(BuildContext context,String element) {
  return Column(
    mainAxisSize: MainAxisSize.min, 
    crossAxisAlignment: CrossAxisAlignment.center, 
    children: [
      Text(
        "คุณเป็นคนธาตุ",
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center, 
      ),
      const SizedBox(height: 10,),
      Text(
        "${thaiElement[element.split(" ")[1]]} ${thaiYinyang[element.split(" ")[0]]}",
        style: Theme.of(context).textTheme.headlineMediumRed,
        textAlign: TextAlign.center,
      ),
    ],
  );
}
