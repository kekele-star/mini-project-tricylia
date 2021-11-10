import 'package:flutter/widgets.dart';

import '../models/location.dart';

class LocationProvider extends ChangeNotifier {
  LocationModel pickUpLocation, dropOffLocation;

  void updatePickUpLocationAddress(LocationModel pickupAddress) {
    pickUpLocation = pickupAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(LocationModel dropOffAddress) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }
}
