import 'package:blabla/widgets/actions/location_picker.dart';
import 'package:flutter/material.dart';
import 'bla_location_picker.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(width: 350, height: 500, child: BlaLocationPicker()),
    );
  }
}
