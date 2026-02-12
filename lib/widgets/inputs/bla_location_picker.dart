import "package:flutter/material.dart";
import 'package:blabla/theme/theme.dart';
import "package:blabla/dummy_data/dummy_data.dart";
import "package:blabla/model/ride/locations.dart";
import 'package:blabla/widgets/display/bla_divider.dart';

class BlaLocationPicker extends StatefulWidget {
  const BlaLocationPicker({super.key});

  @override
  State<BlaLocationPicker> createState() {
    return _BlaLocationPickerState();
  }
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location>? filterLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(hintText: "Search..."),
          onChanged: (value) {
            final query = value.toLowerCase();

            final filter = fakeLocations.where((e) {
              return e.name.toLowerCase().contains(query);
            }).toList();
            setState(() {
              filterLocation = filter;
            });
          },
        ),
        filterLocation == null || filterLocation!.isEmpty
            ? Container()
            : Expanded(
                child: ListView.builder(
                  itemCount: filterLocation!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            filterLocation![index].name,
                            style: BlaTextStyles.heading,
                          ),
                          subtitle: Text(
                            filterLocation![index].country.name,
                            style: BlaTextStyles.body,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                        BlaDivider(),
                      ],
                    );
                  },
                ),
              ),
      ],
    );
  }
}
