import 'package:bazi_app_frontend/constants/constants.dart';
import 'package:flutter/material.dart';

Widget personalElementText(BuildContext context,String element) {
  return RichText(
    text: TextSpan(
      style: Theme.of(context).textTheme.bodyLarge,
      children: [
        const TextSpan(text: "คุณเป็นคนธาตุ "),
        TextSpan(
            text:
                "${thaiElement[element.split(" ")[1]]} ${thaiYinyang[element.split(" ")[0]]}",
            style: Theme.of(context).textTheme.headlineSmall),
      ],
    ),
  );
}
