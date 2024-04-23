import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/core/models/notification.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NotificationView extends StatelessWidget {
  static String routePath = '/notifications-view';

  @override
  Widget build(BuildContext context) {
    final notifications = AppData.notifications.reversed.toList();
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Notification",
        leadingCallback: () => Navigator.pop(context),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color:
                    notifications[index].type == NotificationType.exclusiveOffer
                        ? color.secondary
                        : null),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: notifications[index].type ==
                            NotificationType.exclusiveOffer
                        ? ColorAssets.white
                        : color.secondary,
                    child: SvgPicture.asset(
                        getIconLocation(notifications[index].type)),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notifications[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ColorAssets.blackFaded,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        notifications[index].message,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ColorAssets.lightGray,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  dateFormate(notifications[index].date),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorAssets.lightGray),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String getIconLocation(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.alert:
        return ImageAssets.notificationSvg;

      case NotificationType.exclusiveOffer:
        return ImageAssets.discountSvg;

      case NotificationType.reviewRequest:
        return ImageAssets.starSvg;

      case NotificationType.tourBooked:
        return ImageAssets.successCheckBox;
      default:
        return ImageAssets.settings;
    }
  }

  Widget buildNotificationItem(
      BuildContext context, NotificationModel notification) {
    final color = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
          color: notification.type == NotificationType.exclusiveOffer
              ? color.secondary
              : null),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 25,
              backgroundColor:
                  notification.type == NotificationType.exclusiveOffer
                      ? ColorAssets.white
                      : color.secondary,
              child: SvgPicture.asset(getIconLocation(notification.type)),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: ColorAssets.blackFaded,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorAssets.lightGray,
                  ),
                ),
              ],
            ),
          ),
          Text(
            dateFormate(notification.date),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorAssets.lightGray),
          ),
        ],
      ),
    );
  }

  String dateFormate(DateTime date) {
    final now = DateTime.now();
    final duration = now.difference(date);
    if (duration.inDays != 0) {
      return '${duration.inDays}d';
    } else if (duration.inHours != 0) {
      return '${duration.inHours}h';
    } else {
      return '${duration.inMinutes}m';
    }
  }
}
