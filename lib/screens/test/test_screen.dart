import 'package:blabla/widgets/inputs/bla_location_picker.dart';
import 'package:flutter/material.dart';
import 'package:blabla/theme/theme.dart';
import 'package:blabla/widgets/actions/bla_button.dart';

class TestButton extends StatelessWidget {
  const TestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlaLocationPicker(),
    );
  }
}
