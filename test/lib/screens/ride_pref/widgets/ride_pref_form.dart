import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import 'package:blabla/dummy_data/dummy_data.dart';
import 'package:blabla/theme/theme.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/actions/bla_button.dart';

class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  Location? arrival;
  late DateTime selectedDate;
  int? seats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO: set initial values from initRidePref if available
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      selectedDate = widget.initRidePref!.departureDate;
      seats = widget.initRidePref!.requestedSeats;
    } else {
      selectedDate = DateTime.now();
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // TODO: implement a custom date picker dialog instead of default
  void pickDate(BuildContext context) async {
    DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (ctx) {
        DateTime tempDate = selectedDate;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: 350,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Select Travel Date", style: BlaTextStyles.label),
                ),
                Expanded(
                  child: CalendarDatePicker(
                    initialDate: tempDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onDateChanged: (date) {
                      tempDate = date;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(tempDate);
                  },
                  child: Text("Confirm"),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // TODO: make location selector reusable for departure and arrival
  Widget _locationSelector({
    required IconData icon,
    required String label,
    required Location? selected,
    required Function(Location?) onChanged,
  }) {
    List<DropdownMenuItem<Location>> items = [];
    for (var i = 0; i < fakeLocations.length; i++) {
      items.add(
        DropdownMenuItem(
          value: fakeLocations[i],
          child: Text(
            "${fakeLocations[i].name}, ${fakeLocations[i].country.name}",
            style: BlaTextStyles.label.copyWith(color: BlaColors.primary),
          ),
        ),
      );
    }

    return Card(
      color: BlaColors.backgroundAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            Icon(icon, color: BlaColors.primary),
            SizedBox(width: 12),
            Expanded(
              child: DropdownButton(
                value: selected,
                hint: Text(
                  label,
                  style: BlaTextStyles.label.copyWith(
                    color: BlaColors.greyLight,
                  ),
                ),
                icon: Container(),
                underline: Container(),
                items: items,
                onChanged: onChanged,
                isExpanded: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO: date selector using a different UI than button
  Widget _dateSelector(BuildContext context) {
    return Card(
      color: BlaColors.backgroundAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => pickDate(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: BlaColors.primary),
              SizedBox(width: 12),
              Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                style: BlaTextStyles.label.copyWith(color: BlaColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TODO: simple seat input field
  Widget _seatSelector() {
    return Card(
      color: BlaColors.backgroundAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            Icon(Icons.people, color: BlaColors.primary),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Number of seats",
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  seats = int.tryParse(value) ?? 0;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _locationSelector(
            icon: Icons.flight_takeoff,
            label: "Select Departure",
            selected: departure,
            onChanged: (value) {
              setState(() {
                departure = value;
              });
            },
          ),
          BlaDivider(),
          _locationSelector(
            icon: Icons.flight_land,
            label: "Select Arrival",
            selected: arrival,
            onChanged: (value) {
              setState(() {
                arrival = value;
              });
            },
          ),
          BlaDivider(),
          _dateSelector(context),
          BlaDivider(),
          _seatSelector(),
          SizedBox(height: 10),
          BlaButton(type: BlaButtonType.primary, label: "Search"),
        ],
      ),
    );
  }
}
