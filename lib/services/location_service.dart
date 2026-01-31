import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Check and request location permission
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error('Location services are disabled.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return Future.error('Permission denied.');
    }
    
    return await Geolocator.getCurrentPosition();
  }

  // Check if coordinates are within Raipur boundary (Simplified)
  bool isInRaipur(LatLng pos) {
    // Raipur roughly spans: Lat 21.1 to 21.4, Lng 81.5 to 81.8
    return pos.latitude > 21.1 && pos.latitude < 21.4 &&
           pos.longitude > 81.5 && pos.longitude < 81.8;
  }
}
