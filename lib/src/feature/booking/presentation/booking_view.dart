// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_model.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/bloc/booking_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/bloc/review_bloc.dart'
    as rv;
import 'package:flutter_riverpod_base/src/feature/booking/presentation/views/tour_request_view.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/sheet/book_a_tour_model.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/tabs/about_tab.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/tabs/gallery_tab.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/tabs/review_tab.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/customElevatedContainer.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/custom_tab_builder.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../commons/views/help-center/presentation/pages/help_center_view.dart';

class BookingView extends StatefulWidget {
  final String id;
  static String routePath = '/booking-view';
  final Socket socket;
  const BookingView({
    Key? key,
    required this.id, required this.socket,
  }) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView>
    with SingleTickerProviderStateMixin {
  late TabController _tabBarController;
  num rent = AppData.studioDetails.rent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kDebugMode) {
      print(widget.id);
    }
    context
        .read<BookingBloc>()
        .add(GetBookingDataEvent(params: StudioParams(uid: widget.id)));
    _tabBarController = TabController(length: 3, vsync: this);
  }

  bool isLiked = false;

  toggleLikeButton() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  PageController carouselController = PageController();
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: ColorAssets.white,
      // appBar: AppBar(
      //   forceMaterialTransparency: true,
      //   backgroundColor: Colors.transparent,
      //   leading: Padding(
      //     padding: const EdgeInsets.all(12.0),
      //     child: Container(
      //       width: 20,
      //       height: 20,
      //       decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: ColorAssets.white,
      //           boxShadow: [
      //             BoxShadow(
      //                 color: ColorAssets.lightGray.withOpacity(0.5),
      //                 blurRadius: 1)
      //           ]),
      //       child: GestureDetector(
      //         onTap: () {
      //           context.pop();
      //         },
      //         child: const Icon(
      //           Icons.arrow_back,
      //           size: 20,
      //         ),
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     Container(
      //       width: 30,
      //       height: 30,
      //       decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: color.background,
      //           boxShadow: [
      //             BoxShadow(
      //                 color: ColorAssets.lightGray.withOpacity(0.5),
      //                 blurRadius: 1)
      //           ]),
      //       child: const Icon(
      //         Icons.share,
      //         size: 20,
      //       ),
      //     ).onTap(() {
      //       SharingUtils.shareStudioScrenshotContent(
      //           context: context,
      //           text: "CaptureVision Studios",
      //           subject: "Aram Cottage,Pune ,Maharastra");
      //     }),
      //     const SizedBox(width: 10),
      //     Container(
      //       width: 30,
      //       height: 30,
      //       decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color:color.background,
      //           boxShadow: [
      //             BoxShadow(
      //                 color: ColorAssets.lightGray.withOpacity(0.5),
      //                 blurRadius: 1)
      //           ]),
      //       child: Icon(
      //         isLiked ? Icons.favorite : Icons.favorite_border_rounded,
      //         color:
      //             isLiked ? color.primary:null,
      //         size: 16,
      //       ),
      //     ).onTap(() {
      //       toggleLikeButton();
      //     }),
      //     const SizedBox(width: 20),
      //   ],
      // ),
      appBar: const SimpleAppBar(
        title: "",
        titleWidget: null,
      ),
      bottomNavigationBar: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingSuccessState) {
            rent = AppData.studioDetails.rent;
            return SizedBox(
              height: 80,
              child: CustomElevatedContainer(
                buttonText: "Total Price",
                onTap: () {
                  showTourBookingModel(
                      context, AppData.agentDetails[0], AppData.studioDetails);
                },
                price: "Rs. $rent",
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<BookingBloc>()
              .add(GetBookingDataEvent(params: StudioParams(uid: widget.id)));
        },
        child: DefaultTabController(
            length: 3,
            child: BlocConsumer<BookingBloc, BookingState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is BookingFailure) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Loading Data')
                      ],
                    ),
                  );
                }
                if (state is BookingSuccessState) {
                  final StudioDetails data = AppData.studioDetails;
                  final List<AgentModel> agentModels = AppData.agentDetails;
                  final List<ReviewModel> reviewModel = AppData.reviewModels;
                  AppData.reviewModels = reviewModel;
                  rent = data.rent;
                  return NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          _imageCarouselBuilder(data),
                          _descriptionBuilder(data),
                          SliverPersistentHeader(
                            delegate: SliverAppBarDelegate(
                              TabBar(
                                controller: _tabBarController,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: color.primary,
                                indicator: UnderlineTabIndicator(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 6.0, color: color.primary),
                                    insets: const EdgeInsets.symmetric(
                                        horizontal: 60)),
                                // indicatorWeight: 6,
                                unselectedLabelColor: ColorAssets.lightGray,
                                labelColor: color.primary,
                                tabs: const [
                                  Tab(text: " About "),
                                  Tab(text: " Gallery"),
                                  Tab(text: " Review "),
                                ],
                              ),
                            ),

                            pinned: true,
                            // floating: true,
                          ),
                        ];
                      },
                      body:
                          TabBarView(controller: _tabBarController, children: [
                        AboutTab(
                          agentModels: agentModels,
                          studioDetails: data,
                          
                        ),
                        GalleryTab(studioDetails: data),
                        ReviewTab(
                          reviewModels: AppData.reviewModels,
                          studioDetails: data,
                        ),
                      ]));
                }
                return Center(
                  child: TextButton(
                    child: const Text('Unable to fetch data try refreshing'),
                    onPressed: () async {
                      context.read<BookingBloc>().add(GetBookingDataEvent(
                          params: StudioParams(uid: widget.id)));
                    },
                  ),
                );
              },
            )),
      ),
    );
  }

  SliverToBoxAdapter _descriptionBuilder(StudioDetails data) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        width: double.maxFinite,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTagBuilder(tag: data.category),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 12,
                  ),
                  const SizedBox(width: 5),
                  BlocBuilder<rv.ReviewBloc, rv.ReviewState>(
                    builder: (context, state) {
                      return Text(
                        '${data.rating} (${AppData.reviewModels.length} reviews)',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorAssets.lightGray),
                      );
                    },
                  ),
                  const SizedBox(width: 5),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            data.name,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: ColorAssets.blackFaded),
          ),
          const SizedBox(height: 12),
          Text(
            data.address,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorAssets.blackFaded),
          ),
        ]),
      ),
    );
  }

  SliverToBoxAdapter _imageCarouselBuilder(StudioDetails data) {
    final color = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Container(
        height: 270,
        width: double.maxFinite,
        color: color.primary,
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              controller: carouselController,
              children: [
                for (var i in data.frontImage)
                  Image.memory(
                    i,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox.expand();
                    },
                  ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SmoothPageIndicator(
                    effect: WormEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        activeDotColor: ColorAssets.white,
                        dotColor: color.secondary.withOpacity(0.5)),
                    controller: carouselController,
                    count: 2),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showTourBookingModel(BuildContext context, AgentModel agentModel,
      StudioDetails studioDetails) {
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
            child: TourBookingModelSheet(
              studioDetails: studioDetails,
              agentModel: agentModel,
            ),
          );
        });
  }
}
