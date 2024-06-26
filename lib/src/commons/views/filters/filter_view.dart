import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/presentation/bloc/search_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/presentation/pages/search_results_view.dart';

import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/custom_text_button.dart';

final List<String> amenities = [
  'Backdrop',
  'Props',
  'Lighting Equipment',
  'Camera',
  'Art Supplies',
  'Sound System',
  'Changing Rooms',
];
List<int> selectedamenitiesIndices = [];

class FilterView extends StatefulWidget {
  static String routePath = '/filter-view';
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  int selectedCategoryIndex = 0;
  int? selectedRating;
  late FilterParams filterParams = FilterParams(
      category: AppData.categories[selectedCategoryIndex].title,
      rating: null,
      price: 20000,
      amenities: amenities);
  Color? bgColor;
  Color? textColor;
  String text = '';
  List<CategoryModel> categories = AppData.categories;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is FilterSuccessState) {
          context.push(SearchResultsView.routePath, extra: {'query': 'filter'});
        }
      },
      child: Scaffold(
        appBar: SimpleAppBar(
          title: "Filter",
          leadingCallback: () => context.push(HomeView.routePath),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCategorySection(),
                    RatingCheckBoxBuilder(
                      filterParams: filterParams,
                    ),
                    PricesWrapWidget(
                      filterParams: filterParams,
                    ),
                    AmenitiesWrapWidget(
                      filterParams: filterParams,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 82,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 20),
              decoration: BoxDecoration(
                color: color.surface,
                boxShadow: [
                  BoxShadow(
                      color: color.tertiary, blurRadius: 1, spreadRadius: 0)
                ],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextButton(
                    bgColor: color.primary,
                    text: 'Reset Filter',
                    textColor: color.onPrimary,
                    ontap: () {
                      filterParams = FilterParams(
                          category:
                              AppData.categories[selectedCategoryIndex].title,
                          rating: null,
                          price: 2000,
                          amenities: amenities);
                    },
                  ),
                  CustomTextButton(
                    bgColor: color.primary,
                    text: 'Apply',
                    textColor: color.onPrimary,
                    ontap: () {
                      context.read<SearchBloc>().add(
                          GetFilterResultsEvent(filterParams: filterParams));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategorySection() {
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              // color: ColorAssets.blackFaded,
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: index == 0 ? 0 : 15),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: selectedCategoryIndex == index
                          ? color.primary
                          : color.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      categories[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: selectedCategoryIndex == index
                            ? color.onPrimary
                            : color.onSecondary,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class AmenitiesWrapWidget extends StatefulWidget {
  const AmenitiesWrapWidget({super.key, required this.filterParams});
  final FilterParams filterParams;
  @override
  State<AmenitiesWrapWidget> createState() => _AmenitiesWrapWidgetState();
}

class _AmenitiesWrapWidgetState extends State<AmenitiesWrapWidget> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              "Amenities",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                // color: ColorAssets.blackFaded,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 6.0,
            runSpacing: 15.0,
            children: List.generate(amenities.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedamenitiesIndices.contains(index)) {
                      selectedamenitiesIndices.remove(index);
                      final lists = selectedamenitiesIndices
                          .map((e) => amenities[e])
                          .toList();
                      widget.filterParams.copyWith(amenities: lists);
                    } else {
                      selectedamenitiesIndices.add(index);
                      final lists = selectedamenitiesIndices
                          .map((e) => amenities[e])
                          .toList();
                      widget.filterParams.copyWith(amenities: lists);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: selectedamenitiesIndices.contains(index)
                        ? color.primary
                        : color.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    amenities[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: selectedamenitiesIndices.contains(index)
                          ? color.onPrimary
                          : color.onSecondary,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class PricesWrapWidget extends StatefulWidget {
  const PricesWrapWidget({
    Key? key,
    required this.filterParams,
  }) : super(key: key);
  final FilterParams filterParams;
  @override
  State<PricesWrapWidget> createState() => _PricesWrapWidgetState();
}

class _PricesWrapWidgetState extends State<PricesWrapWidget> {
  final List<num> prices = [100, 500, 2000, 5000, 10000, 20000];

  int? selectedPriceIndex;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              "Price",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                // color: ColorAssets.blackFaded,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 6.0,
            runSpacing: 15.0,
            children: List.generate(prices.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPriceIndex = index;
                    widget.filterParams.copyWith(
                        price: prices[selectedPriceIndex ?? prices.length - 1]);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 6,
                  ),
                  // name@gmail.com name123
                  decoration: BoxDecoration(
                    color: selectedPriceIndex == index
                        ? color.primary
                        : color.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '< Rs. ${prices[index]}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: selectedPriceIndex == index
                          ? color.onPrimary
                          : color.onSecondary,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class RatingCheckBoxBuilder extends StatefulWidget {
  const RatingCheckBoxBuilder({Key? key, required this.filterParams})
      : super(key: key);
  final FilterParams filterParams;
  @override
  RatingCheckBoxBuilderState createState() => RatingCheckBoxBuilderState();
}

class RatingCheckBoxBuilderState extends State<RatingCheckBoxBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rating",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              // color: ColorAssets.blackFaded,
            ),
          ),
          buildCheckBox(5, "4.5 and above"),
          buildCheckBox(4, "4.0 - 4.5"),
          buildCheckBox(3, "3.5 - 3.0"),
          buildCheckBox(2, "3.0 - 2.5"),
          buildCheckBox(1, "2.5 - 1.0"),
        ],
      ),
    );
  }

  Widget buildCheckBox(int rating, String label) {
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              activeColor: color.primary,
              value: widget.filterParams.rating == rating,
              onChanged: (value) {
                setState(() {
                  widget.filterParams.copyWith(rating: value! ? rating : null);
                });
              },
            ),
          ),
          const SizedBox(width: 20),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              // color: ColorAssets.blackFaded,
            ),
          ),
        ],
      ),
    );
  }
}
