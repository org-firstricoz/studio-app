import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';

import '../../../utils/custom_text_button.dart';

class FilterView extends StatefulWidget {
  static String routePath = '/filter-view';
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  int selectedCategoryIndex = 0;

  Color? bgColor;
  Color? textColor;
  String text = '';
  List<CategoryModel> categories = AppData.categories;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: SimpleAppBar(
        title: "Filter",
        leadingCallback: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCategorySection(),
                  const RatingCheckBoxBuilder(),
                  const PricesWrapWidget(),
                  const AmenitiesWrapWidget(),
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
                BoxShadow(color: color.tertiary, blurRadius: 1, spreadRadius: 0)
              ],
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextButton(
                  bgColor: color.primary,
                  text: 'Reset Filter',
                  textColor: color.onPrimary,
                  ontap: () {},
                ),
                CustomTextButton(
                  bgColor: color.primary,
                  text: 'Apply',
                  textColor: color.onPrimary,
                  ontap: () {},
                )
              ],
            ),
          ),
        ],
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
                            : color.tertiary,
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
  const AmenitiesWrapWidget({super.key});

  @override
  State<AmenitiesWrapWidget> createState() => _AmenitiesWrapWidgetState();
}

class _AmenitiesWrapWidgetState extends State<AmenitiesWrapWidget> {
  final List<String> prices = [
    'Backdrop',
    'Props',
    'Lighting Equipment',
    'Camera',
    'Art Supplies',
    'Sound System',
    'Changing Rooms',
  ];

  List<int> selectedPriceIndices = [];

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
            children: List.generate(prices.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedPriceIndices.contains(index)) {
                      selectedPriceIndices.remove(index);
                    } else {
                      selectedPriceIndices.add(index);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: selectedPriceIndices.contains(index)
                        ? color.primary
                        : color.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    prices[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: selectedPriceIndices.contains(index)
                          ? color.surface
                          : color.tertiary,
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
  }) : super(key: key);

  @override
  State<PricesWrapWidget> createState() => _PricesWrapWidgetState();
}

class _PricesWrapWidgetState extends State<PricesWrapWidget> {
  final List<String> prices = [
    "Under \$100",
    "Under \$500",
    "\$5000",
    "\$1500-\$3000",
    "\$1000-\$1500",
  ];

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
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: selectedPriceIndex == index
                        ? color.primary
                        : color.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    prices[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: selectedPriceIndex == index
                          ? color.background
                          : color.tertiary,
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
  const RatingCheckBoxBuilder({Key? key}) : super(key: key);

  @override
  _RatingCheckBoxBuilderState createState() => _RatingCheckBoxBuilderState();
}

class _RatingCheckBoxBuilderState extends State<RatingCheckBoxBuilder> {
  int? selectedRating = 5;

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
              value: selectedRating == rating,
              onChanged: (value) {
                setState(() {
                  selectedRating = value! ? rating : null;
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
