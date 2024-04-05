// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod_base/src/core/utils.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';

final GroupedNotifications groupedNotifications =
    GroupedNotifications.fromList(AppData.notifications);
final String jsonString = groupedNotifications.toJsonString();

class GroupedNotifications {
  final List<NotificationDate> notificationDates;

  GroupedNotifications({
    required this.notificationDates,
  });

  factory GroupedNotifications.fromList(List<NotificationModel> notifications) {
    Map<String, List<NotificationModel>> groupedMap = {};

    for (var notification in notifications) {
      final String formattedDate = _formatDate(notification.date);
      if (!groupedMap.containsKey(formattedDate)) {
        groupedMap[formattedDate] = [];
      }
      groupedMap[formattedDate]!.add(notification);
    }

    List<NotificationDate> notificationDates = groupedMap.entries.map((entry) {
      return NotificationDate(
        date: entry.key,
        notifications: entry.value,
      );
    }).toList();

    return GroupedNotifications(notificationDates: notificationDates);
  }

  String toJsonString() {
    List<Map<String, dynamic>> jsonList =
        notificationDates.map((notificationDate) {
      return {
        'date': notificationDate.date,
        'notifications': notificationDate.notifications.map((notification) {
          return {
            'title': notification.title,
            'message': notification.message,
            'type': notification.type.toString().split('.').last,
            'date': notification.date.toIso8601String(),
          };
        }).toList(),
      };
    }).toList();

    return jsonEncode(jsonList);
  }
}

class NotificationDate {
  final String date;
  final List<NotificationModel> notifications;

  NotificationDate({
    required this.date,
    required this.notifications,
  });
}

class NotificationModel {
  final String title;
  final String message;
  final NotificationType type;
  final DateTime date;

  NotificationModel({
    required this.title,
    required this.message,
    required this.type,
    required this.date,
  });

  NotificationModel copyWith({
    String? title,
    String? message,
    NotificationType? type,
    DateTime? date,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'type': type.toString(),
      'date': date.toIso8601String(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String,
      message: map['message'] as String,
      type: stringToEnum(map['type']),
      date: DateTime.tryParse(map['date'].toString()) ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(title: $title, message: $message, type: $type, date: $date)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.message == message &&
        other.type == type &&
        other.date == date;
  }

  @override
  int get hashCode {
    return title.hashCode ^ message.hashCode ^ type.hashCode ^ date.hashCode;
  }
}

enum NotificationType {
  tourBooked,
  exclusiveOffer,
  reviewRequest,
  alert,
  nulls
}

String _formatDate(DateTime date) {
  final now = DateTime.now();
  if (isSameDay(date, now)) {
    return 'Today';
  } else if (isSameDay(date, now.subtract(const Duration(days: 1)))) {
    return 'Yesterday';
  } else {
    return '${date.day}/${date.month}/${date.year}';
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
