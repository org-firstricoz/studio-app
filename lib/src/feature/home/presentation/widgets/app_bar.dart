import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod_base/src/commons/views/location_access/location_access_page.dart';
import 'package:flutter_riverpod_base/src/commons/views/notification/notification_view.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:go_router/go_router.dart';

class HomeViewAppBar extends StatelessWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: color.secondary,
        backgroundImage: NetworkImage(
          user.photoUrl,
        ),
      ),
      title: Text(
        user.name,
        style: TextStyle(
            fontSize: 18,
            // color: ColorAssets.blackFaded,
            fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              context.push(LocationAccessPage.routePath);
            },
            child: Text(
              user.location,
              style: TextStyle(
                  fontSize: 14,
                  color: color.onSurface,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: color.onSurface,
          )
        ],
      ),
      trailing: GestureDetector(
        onTap: () {
          context.push(NotificationView.routePath);
        },
        child: CircleAvatar(
          backgroundColor: color.secondary,
          child: Badge(
            child: Icon(
              Icons.notifications,
              color: color.onBackground,
            ),
          ),
        ),
      ),
    );
  }
}
