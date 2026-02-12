import 'package:blabla/theme/theme.dart';
import 'package:blabla/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlaButton(
            icon: Icons.message,
            type: BlaButtonType.secondary,
            label: "Contact Volodia",
          ),
          SizedBox(height: 10),
          BlaButton(
            icon: Icons.calendar_month,
            type: BlaButtonType.primary,
            label: "Request to book",
          ),
        ],
      ),
    );
  }
}
