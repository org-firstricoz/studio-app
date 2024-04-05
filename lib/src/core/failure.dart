class Failure{
  final String message;
  final StackTrace stackTrace;

  Failure({
    required this.message,
    this.stackTrace = StackTrace.empty,
  });
}

class ApiFailure extends Failure{
  ApiFailure({required super.message});
}

class LocationFailure extends Failure{
  LocationFailure({required super.message});
}