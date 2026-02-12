import 'package:blabla/widgets/inputs/bla_location_picker.dart';
import 'package:flutter/material.dart';
import 'package:blabla/theme/theme.dart';
import 'package:blabla/widgets/actions/bla_button.dart';

class TestButton extends StatelessWidget {
  const TestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlaButton(
            color: BlaColors.backgroundAccent,
            label: "Contact Volodia",
            icon: Icons.message,
          ),
          SizedBox(height: 10),
          BlaButton(
            color: BlaColors.primary,
            label: "Request to book",
            icon: Icons.calendar_month,
          ),
          BlaLocationPicker(),
        ],
      ),
    );
  }
}
