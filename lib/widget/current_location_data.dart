import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String> getLocationData({double? latitude, double? longitude}) async {
  String res = "";

  bool v(String? s) => s != null && s.isNotEmpty;

  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude!);
    Placemark p = placemarks.first;

    if (v(p.street)) res = "$res${p.street}, ";
    if (v(p.locality)) res = "$res${p.locality}, ";
    if (v(p.subLocality)) res = "$res${p.subLocality}, ";
    if (v(p.country)) res = "$res${p.country}, ";
  } catch (_) {}

  return res;
}

double getLocationDistance({required double startLatitude, required double startLongitude, required double endLatitude, required double endLongitude}) {
  return Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
}
