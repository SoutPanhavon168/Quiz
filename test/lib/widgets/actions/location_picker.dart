import "package:blabla/dummy_data/dummy_data.dart";
import "package:blabla/model/ride/locations.dart";
import "package:flutter/material.dart";
import 'package:blabla/theme/theme.dart';
import 'package:blabla/widgets/display/bla_divider.dart';

class BlaLocationPicker extends StatefulWidget {
  const BlaLocationPicker({super.key});

  @override
  State<BlaLocationPicker> createState() {
    return _BlaLocationPickerState();
  }
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> resultList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: const InputDecoration(
              hintText: "Search city",
              border: InputBorder.none,
            ),
            onChanged: (inputText) {
              List<Location> newList = [];

              for (int i = 0; i < fakeLocations.length; i++) {
                String nameLower = fakeLocations[i].name.toLowerCase();

                if (nameLower.startsWith(inputText.toLowerCase())) {
                  newList.add(fakeLocations[i]);
                }
              }

              setState(() {
                resultList = newList;
              });
            },
          ),
        ),
        resultList.isEmpty
            ? const SizedBox()
            : Expanded(
                child: ListView.builder(
                  itemCount: resultList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.location_city),
                          title: Text(
                            resultList[index].name,
                            style: BlaTextStyles.heading,
                          ),
                          subtitle: Text(
                            resultList[index].country.name,
                            style: BlaTextStyles.body,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                        const BlaDivider(),
                      ],
                    );
                  },
                ),
              ),
      ],
    );
  }
}
