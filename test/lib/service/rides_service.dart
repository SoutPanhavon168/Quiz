import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  //
  //  filter the rides starting from given departure location
  //
  static List<Ride> filterByDeparture(Location departure) {
    List<Ride> result = [];

    for (Ride ride in availableRides) {
      if (ride.departureLocation.name == departure.name &&
          ride.departureLocation.country == departure.country) {
        result.add(ride);
      }
    }
    return result;
  }

  //
  //  filter the rides starting for the given requested seat number
  //

  static List<Ride> filterBySeatRequested(int seatRequested) {
    List<Ride> result = [];
    for (Ride ride in availableRides) {
      if (ride.availableSeats >= seatRequested) {
        result.add(ride);
      }
    }
    return result;
  }

  //
  //  filter the rides   with several optional criteria (flexible filter options)
  //

  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    return [];
  }
}
