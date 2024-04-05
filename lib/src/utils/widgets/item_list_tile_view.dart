// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/booking_view.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';

class ItemListTileView extends StatefulWidget {
  final StudioModel studioModel;
  final VoidCallback onTap;
  const ItemListTileView({
    Key? key,
    required this.studioModel,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ItemListTileView> createState() => _ItemListTileViewState();
}

class _ItemListTileViewState extends State<ItemListTileView> {
  bool isLiked = false;
  toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      width: double.maxFinite,
      height: 124,
      decoration: BoxDecoration(
        boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 2)],
        borderRadius: BorderRadius.circular(6),
        color: color.surface,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 104,
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    widget.studioModel.image,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: toggleLike,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: color.secondary.withOpacity(0.6),
                        child: Icon(
                          isLiked
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: isLiked ? color.primary : color.primary,
                          size: 16,
                        ),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: color.secondary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        widget.studioModel.tag,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: color.primary),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 12,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.studioModel.rating.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorAssets.lightGray),
                        ),
                        SizedBox(width: 18),
                      ],
                    )
                  ],
                ),
                Text(
                  widget.studioModel.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // color: ColorAssets.blackFaded,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      // color: ColorAssets.lightGray,
                      size: 12,
                    ),
                    Text(
                      widget.studioModel.location,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        // color: ColorAssets.lightGray,
                      ),
                    ),
                  ],
                ),
                RichText(
                    text: TextSpan(
                        text: "\$${widget.studioModel.rent}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: color.primary),
                        children: [
                      TextSpan(
                        text: " /month",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorAssets.lightGray,
                        ),
                      )
                    ])),
              ],
            ),
          ),
        ],
      ),
    ).onTap(widget.onTap);
  }
}
