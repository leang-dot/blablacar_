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
  List<Location> filteredLocations = [];
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(hintText: "Search Location..."),
            onChanged: (value) {
              final query = value.toLowerCase();

              setState(() {
                searchQuery = query;

                if (query.isEmpty) {
                  filteredLocations = [];
                } else {
                  filteredLocations = fakeLocations.where((e) {
                    return e.name.toLowerCase().contains(query);
                  }).toList();
                }
              });
            },
          ),
        ),
        Expanded(
          child: searchQuery.isEmpty
              ? Center(
                  child: Text(
                    "Search for a location",
                    style: BlaTextStyles.body,
                  ),
                )
              : filteredLocations.isEmpty
              ? Center(
                  child: Text("No locations found", style: BlaTextStyles.body),
                )
              : ListView.builder(
                  itemCount: filteredLocations.length,
                  itemBuilder: (context, index) {
                    final location = filteredLocations[index];

                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            location.name,
                            style: BlaTextStyles.heading,
                          ),
                          subtitle: Text(
                            location.country.name,
                            style: BlaTextStyles.body,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                          ),
                          onTap: () {
                            Navigator.pop(context, location);
                          },
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
