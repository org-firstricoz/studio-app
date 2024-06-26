import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliverAppbarwithSearchBar extends StatelessWidget {
  const SliverAppbarwithSearchBar(
      {super.key,
      required this.context,
      required bool isSliverAppBarExpanded,
      required this.controller,
      required this.title,
      this.bgColor,
      this.statusbarColor,
      this.onChange,
      this.onSubmit})
      : _isSliverAppBarExpanded = isSliverAppBarExpanded;

  final BuildContext context;
  final Color? statusbarColor;
  final Color? bgColor;
  final bool _isSliverAppBarExpanded;
  final String title;
  final TextEditingController controller;
  final Function(String text)? onChange;
  final Function(String text)? onSubmit;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      forceMaterialTransparency: false,
      backgroundColor: bgColor ?? colorScheme.secondary,
      snap: true,
      floating: true,
      pinned: true,
      centerTitle: true,
      title: !_isSliverAppBarExpanded
          ? Text(
              title,
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            )
          : null,
      bottom: PreferredSize(
        preferredSize: const Size(double.maxFinite, 70),
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: statusbarColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: onChange,
                  onFieldSubmitted: onSubmit,
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
