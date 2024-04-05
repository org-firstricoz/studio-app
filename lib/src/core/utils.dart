import 'package:flutter_riverpod_base/src/core/models/notification.dart';
import 'package:fpdart/fpdart.dart';

NotificationType stringToEnum(String value) {
  print(value);
  return NotificationType.values.firstWhere(
    (e) => e.toString().split('.').last == value,
    orElse: () => NotificationType.nulls,
  );
}
