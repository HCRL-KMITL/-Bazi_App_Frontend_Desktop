import 'package:flutter/material.dart';
import 'package:bazi_app_frontend/configs/theme.dart';

class GenderSelectorWidget extends StatefulWidget {
  final ValueChanged<int> onGenderSelected;
  const GenderSelectorWidget({super.key, required this.onGenderSelected});

  @override
  State<GenderSelectorWidget> createState() => _GenderSelectorWidgetState();
}

class _GenderSelectorWidgetState extends State<GenderSelectorWidget> {
  int selectedGender = 0;

  void updateGenderSelection(int gender) {
    setState(() {
      selectedGender = gender;
    });
    widget.onGenderSelected(gender);
  }

  @override
  Widget build(BuildContext context) {
    const Color wColor = Color(0xFFF5E6E8);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        GestureDetector(
          onTap: () => updateGenderSelection(0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: selectedGender == 0
                    ? fcolor
                    : Theme.of(context).disabledColor,
                borderRadius: BorderRadius.circular(20)),
            child: Icon(
              Icons.male,
              color: selectedGender == 0 ? wColor : Colors.black,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => updateGenderSelection(1),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: selectedGender == 1
                    ? fcolor
                    : Theme.of(context).disabledColor,
                borderRadius: BorderRadius.circular(20)),
            child: Icon(
              Icons.female,
              color: selectedGender == 1 ? wColor : Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
