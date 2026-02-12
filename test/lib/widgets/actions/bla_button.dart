import 'package:flutter/material.dart';
import 'package:blabla/theme/theme.dart';

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final BlaButtonType type;

  const BlaButton({
    super.key,
    required this.type,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    if (type == BlaButtonType.primary) {
      backgroundColor = BlaColors.backGroundColor;
      textColor = BlaColors.white;
    } else {
      backgroundColor = BlaColors.backgroundAccent;
      textColor = BlaColors.primary;
    }

    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
      icon: icon != null ? Icon(icon, color: textColor) : Container(),
      label: Text(label, style: BlaTextStyles.label.copyWith(color: textColor)),
    );
  }
}
