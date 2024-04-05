class LocationException implements Exception {
  final String message;

  LocationException({required this.message});
}

class ApiException implements Exception {
  final String message;

  ApiException({required this.message});
}

class FavouriteException implements Exception {
  final String message;

  FavouriteException({required this.message});
}
