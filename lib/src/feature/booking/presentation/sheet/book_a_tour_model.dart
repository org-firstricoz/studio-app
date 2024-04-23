// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:flutter_riverpod_base/src/core/models/agent_model.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/views/book_tour_view.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/chat_view.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/customElevatedContainer.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/custom_tab_builder.dart';

GlobalKey scaffold = GlobalKey<ScaffoldState>();

class TourBookingModelSheet extends StatefulWidget {
  const TourBookingModelSheet({
    Key? key,
    required this.studioDetails,
    required this.agentModel,
  }) : super(key: key);
  final AgentModel agentModel;
  final StudioDetails studioDetails;

  @override
  State<TourBookingModelSheet> createState() => _TourBookingModelSheetState();
}

class _TourBookingModelSheetState extends State<TourBookingModelSheet> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  double rating = 0;

  bool isLiked = false;

  toogleLikeButton() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final studioDetails = widget.studioDetails;
    return Container(
      decoration: BoxDecoration(
          color: color.secondary,
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
                                    '${widget.studioDetails.rating} (${widget.studioDetails.numberOfReviews} reviews)',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: ColorAssets.lightGray),
                                  ),
                                  const SizedBox(width: 18),
                                ],
                              )
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
                  const Divider(
                    height: 1,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Book Tour",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: color.onSecondary,
                          fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Day & Time ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: ColorAssets.blackFaded,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // time selecting
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () async {
                            final DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 50)));
                            if (date != null) {
                              selectedDate = date;
                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.calendar_month)),
                      selectedDate != null
                          ? Text(DateFormat('dd-MM-yyyy').format(selectedDate!))
                          : SizedBox.fromSize(),
                      selectedTime != null
                          ? Text(selectedTime!.format(context))
                          : SizedBox.fromSize(),
                      IconButton(
                          onPressed: () async {
                            final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    DateTime.now()
                                        .add(const Duration(hours: 10))));
                            if (time != null) {
                              selectedTime = time;
                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.watch_rounded)),
                    ],
                  ),

                  // time selecting

                  // time selecting

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    padding: const EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: color.primary, width: 3))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Want a custom scheduler?",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: ColorAssets.blackFaded),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push(ChatView.routePath,
                                extra: {'agent_model': widget.agentModel});
                          },
                          child: Text(
                            "Request Schedule",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: color.primary),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
          // submit button

          CustomElevatedContainer(
            buttonText: "Schedule Tour",
            onTap: () {
              if (selectedDate != null && selectedTime != null) {
                context.push(BookingTourView.routePath, extra: {
                  'studio_details': studioDetails,
                  'date': selectedDate,
                  'time': selectedTime,
                });
              }
            },
          )
        ],
      ),
    );
  }
}
