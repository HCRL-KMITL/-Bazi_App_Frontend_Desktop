import 'package:flutter/material.dart';

class MonthlyPredictionWidget extends StatelessWidget {
  const MonthlyPredictionWidget({required this.predText, super.key});

  final String predText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Scrollbar(
            trackVisibility: true,
            child: SingleChildScrollView(
              child: Text(
                predText,
                softWrap: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
