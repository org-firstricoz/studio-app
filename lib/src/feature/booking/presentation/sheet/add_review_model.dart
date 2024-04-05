// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/bloc/booking_bloc.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/custom_text_button.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/custom_tab_builder.dart';
import 'package:go_router/go_router.dart';

class AddReviewModel extends StatefulWidget {
  const AddReviewModel({
    Key? key,
    required this.studioDetails,
  }) : super(key: key);
  final StudioDetails studioDetails;

  @override
  State<AddReviewModel> createState() => _AddReviewModelState();
}

class _AddReviewModelState extends State<AddReviewModel> {
  TextEditingController reviewEditingController = TextEditingController();
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      decoration: const BoxDecoration(
          color: ColorAssets.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.maxFinite,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTagBuilder(
                                  tag: widget.studioDetails.category),
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
                                    '${widget.studioDetails.rating}(${widget.studioDetails.numberOfReviews} reviews)',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: ColorAssets.lightGray),
                                  ),
                                  const SizedBox(width: 18),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            widget.studioDetails.name,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: ColorAssets.blackFaded),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.studioDetails.address,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ColorAssets.blackFaded),
                          ),
                        ]),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),

                  // ratingd
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Your overall rating for this studio",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RatingBar.builder(
                          initialRating: rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 7.5),
                          itemSize: 50,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (value) {
                            setState(() {
                              rating = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // write review
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Add detailed review',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ColorAssets.blackFaded),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: TextField(
                      controller: reviewEditingController,
                      // scrollPadding: EdgeInsets.all(0),

                      minLines: 6,
                      maxLines: 15,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Enter review',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                          fillColor: color.secondary,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  const SizedBox(height: 10),
                ]),
              ),
            ),
          ),

          // submit button

          Container(
            height: 82,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                color: color.surface,
                boxShadow: const [
                  BoxShadow(color: ColorAssets.lightGray, blurRadius: 3)
                ],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: Center(
              child: CustomTextButton(
                  text: "Submit",
                  ontap: () async {
                    //ontaps
                    if (reviewEditingController.text.trim().isNotEmpty && rating !=0) {
                      context.read<BookingBloc>().add(AddReviewEvent(
                          params: ReviewParams(
                              createdAt: DateTime.now(),
                              rating: rating,
                              review: reviewEditingController.text.trim(),
                              uuid: user.uuid)));
                      context.pop();
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
