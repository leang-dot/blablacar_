import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import 'package:blabla/dummy_data/dummy_data.dart';
import 'package:blabla/widgets/actions/bla_button.dart';
import 'package:blabla/theme/theme.dart';
import '../../../widgets/display/bla_divider.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  DateTime? departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  void initialValue() {
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO
    initialValue();
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _departureWidget(),
        BlaDivider(),
        _arrivalWidget(),
        BlaDivider(),
        _datePickerWidget(context),
        BlaDivider(),
        _requestSeatWidget(),
        BlaButton(color: BlaColors.primary, label: "Search"),
      ],
    );
  }

  Widget _requestSeatWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.person)),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (value) {
              int result = int.parse(value);
              setState(() {
                requestedSeats = result;
              });
            },
            keyboardType: TextInputType.numberWithOptions(),
          ),
        ),
      ],
    );
  }

  void pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != departureDate) {
      setState(() {
        departureDate = pickedDate;
      });
    }
  }

  Widget _datePickerWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.calendar_month),
          onPressed: () {
            pickDate(context);
          },
        ),
        Text(
            departureDate == null
                ? "Select Date"
                : "${departureDate!.day}/${departureDate!.month}/${departureDate!.year}",
            style: BlaTextStyles.label.copyWith(
              color: departureDate == null
                  ? BlaColors.greyLight
                  : BlaColors.primary,
            ),
          ),
      ],
    );
  }

  Widget _departureWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.location_on_rounded),
        ),
        DropdownButton(
          hint: Text(
            "Leaving From",
            style: BlaTextStyles.label.copyWith(color: BlaColors.greyLight),
          ),
          icon: Container(),
          underline: Container(),
          value: departure,
          items: [
            ...fakeLocations.map((element) {
              return DropdownMenuItem(
                value: element,
                child: Text(
                  element.name,
                  style: BlaTextStyles.label.copyWith(color: BlaColors.primary),
                ),
              );
            }),
          ],
          onChanged: (value) {
            setState(() {
              departure = value;
            });
          },
        ),
      ],
    );
  }

  Widget _arrivalWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.location_on_rounded),
        ),
        DropdownButton(
          hint: Text(
            "Going To",
            style: BlaTextStyles.label.copyWith(color: BlaColors.greyLight),
          ),
          icon: Container(),
          underline: Container(),
          value: arrival,
          items: [
            ...fakeLocations.map((element) {
              return DropdownMenuItem(
                value: element,
                child: Text(
                  "${element.name} , ${element.country.name}",
                  style: BlaTextStyles.label.copyWith(color: BlaColors.primary),
                ),
              );
            }),
          ],
          onChanged: (value) {
            setState(() {
              arrival = value;
            });
          },
        ),
      ],
    );
  }
}
