import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:geocoding/geocoding.dart';

locationFromAdd(String location) async {
  try {
    final localLocation =
        await GeocodingPlatform.instance!.locationFromAddress(location);
    latitude = localLocation.first.latitude;
    longitude = localLocation.first.longitude;
    print(latitude);
    print(longitude);
  } catch (e) {
    latitude = 0;
    longitude = 0;
  }
}

locationFromAddforStudio(String location) async {
  final localLocation =
      await GeocodingPlatform.instance!.locationFromAddress(location);
  final latitude = localLocation.first.latitude;
  final longitude = localLocation.first.longitude;
  print(latitude);
  print(longitude);
  return [latitude, longitude];
}
