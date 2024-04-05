import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/studio_app_bar.dart';
import 'package:go_router/go_router.dart';

class BasicSliverAppbar extends SliverPersistentHeaderDelegate {
  final String title;
  final List<Widget>? actions;
  BasicSliverAppbar({required this.title, this.actions});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SimpleAppBar(title: title, actions: actions);
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
