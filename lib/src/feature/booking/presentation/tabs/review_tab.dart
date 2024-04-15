// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/tabs/widget/filter_option_dialogue.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:intl/intl.dart';

import '../sheet/add_review_model.dart';
import 'widget/filter_option_widget.dart';

class ReviewTab extends StatefulWidget {
  const ReviewTab({
    Key? key,
    required this.reviewModels,
    required this.studioDetails,
  }) : super(key: key);
  final List<ReviewModel> reviewModels;
  final StudioDetails studioDetails;

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Reviews",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorAssets.blackFaded),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit,
                          size: 14,
                          color: color.primary,
                        ),
                        GestureDetector(
                          onTap: () => openReviewModelSheet(context),
                          child: Text(
                            "add reviews",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: color.primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    FilterOptionsWidget(
                      label: 'Filter',
                      onTap: () => _showFilterOptionsDialog(context),
                      isSelected: selectedFilter != ReviewFilterEnum.all,
                    ),
                    const SizedBox(width: 15),
                    FilterOptionsWidget(
                      label: 'All',
                      onTap: () {
                        setState(() {
                          selectedFilter = ReviewFilterEnum.all;
                        });
                      },
                      isSelected: selectedFilter == ReviewFilterEnum.all,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // reviews

          const Divider(height: 1),

          _reviewBuilder(filter: selectedFilter)
        ],
      ),
    );
  }

  ReviewFilterEnum selectedFilter = ReviewFilterEnum.all;
  void _showFilterOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterOptionsDialog(
          onOptionSelected: (option) {
            setState(() {
              selectedFilter = option;
              switch (option) {
                case ReviewFilterEnum.lowRating:
                  AppData.reviewModels
                      .sort((a, b) => a.rating.compareTo(b.rating));
                  break;
                case ReviewFilterEnum.highRating:
                  AppData.reviewModels
                      .sort((a, b) => b.rating.compareTo(a.rating));
                  break;
                case ReviewFilterEnum.newReviews:
                  AppData.reviewModels.sort((a, b) => b.time.compareTo(a.time));
                  break;
                case ReviewFilterEnum.oldReviews:
                  AppData.reviewModels.sort((a, b) => a.time.compareTo(b.time));
                  break;
                case ReviewFilterEnum.all:
                  AppData.reviewModels.sort((a, b) => a.name.compareTo(b.name));
              }
            });
          },
        );
      },
    );
  }

  _reviewBuilder({required ReviewFilterEnum filter}) {
    final review = AppData.reviewModels;

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final color = Theme.of(context).colorScheme;

        return Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorAssets.lightGray))),
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 17, top: 17),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: color.secondary,
                radius: 15,
                backgroundImage: NetworkImage(review[index].photoUrl),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            review[index].name,
                            style: const TextStyle(
                              color: ColorAssets.blackFaded,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            DateFormat("dd-MM-yyyy").format(review[index].time),
                            style: const TextStyle(
                              color: ColorAssets.lightGray,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      review[index].review,
                      softWrap: true,
                      style: const TextStyle(
                        color: ColorAssets.lightGray,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    //raiting
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rate,
                          size: 16,
                          color: ColorAssets.yellow,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          review[index].rating.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: ColorAssets.lightGray),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: review.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  void openReviewModelSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: ColorAssets.white,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            // padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height - 200,
            decoration: const BoxDecoration(
                color: ColorAssets.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            child: AddReviewModel(
              studioDetails: widget.studioDetails,
            ),
          );
        });
  }
}
