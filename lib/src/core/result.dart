abstract class Result {
  final String? successId;
  final String? failureId;

  Result({this.successId, this.failureId});
}

final class SuccessClass extends Result {
  SuccessClass({
    required super.successId,
  });
}

final class FailureClass extends Result {
  FailureClass({required super.failureId});
}
