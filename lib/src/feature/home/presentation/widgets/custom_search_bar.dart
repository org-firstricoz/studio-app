import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/views/filters/filter_view.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/presentation/pages/studio_search_view.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:go_router/go_router.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color.secondary),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: "Search",
                  hintStyle: TextStyle(color: color.onSecondary),
                  prefixIcon: Icon(
                    Icons.search,
                    color: color.onSecondary,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ).onTap(() {
              context.push(StudioSearchView.routePath);
            }),
          ),
          const SizedBox(width: 10),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.tune,
              color: color.surface,
              size: 20,
            ),
          ).onTap(() {
            context.push(FilterView.routePath);
          }),
        ],
      ),
    );
  }
}
