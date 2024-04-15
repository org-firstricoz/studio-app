// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/booking_view.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/bloc/home_view_bloc.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:flutter_riverpod_base/src/utils/form_text_field.dart';

import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../res/colors.dart';
import '../../../../utils/widgets/item_list_tile_view.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  List<StudioModel> allModels = AppData.favouriteModel;
  String searchTerm = "";

  TextEditingController searchEditingController =
      TextEditingController(text: '');
  List<CategoryModel> categories = [
    CategoryModel(image: 'image', title: 'All')
  ];
  int sealectedCategoryIndex = 0;
  bool showsSearchBar = false;
  void toggleSearchBar() {
    showsSearchBar = !showsSearchBar;
    searchTerm = '';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    categories.addAll(AppData.categories);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourites',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: toggleSearchBar, icon: const Icon(Icons.search))
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: () async {
          context.read<HomeViewBloc>().add(FetchingStudioDataEvent(
                  params: AllParams(
                location: user.location,
              )));
        },
        child: BlocConsumer<HomeViewBloc, AllDataState>(
          listener: (context, state) {
            if (state is HomeViewFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Loading Data'),
                  ],
                ),
              );
            }
            return Column(
              children: [
                PreferredSize(
                    preferredSize: Size.fromHeight(showsSearchBar ? 100 : 40),
                    child: Column(children: [
                      showsSearchBar
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: FormTextField(
                                controller: searchEditingController
                                  ..text = searchTerm,
                                onChanged: changeSearchText,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      searchTerm = '';
                                      searchEditingController.clear();
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.clear)),
                                hintText: "Search..",
                              ),
                            )
                          : const SizedBox.shrink(),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) => Container(
                            height: 29,
                            margin: EdgeInsets.only(left: index == 0 ? 20 : 15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17, vertical: 6),
                            decoration: BoxDecoration(
                                color: sealectedCategoryIndex == index
                                    ? colorScheme.primary
                                    : ColorAssets.lightBlueGray,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                categories[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: sealectedCategoryIndex == index
                                        ? ColorAssets.white
                                        : ColorAssets.lightGray),
                              ),
                            ),
                          ).onTap(() {
                            setState(() {
                              sealectedCategoryIndex = index;
                            });
                          })),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: allModels.length,
                    itemBuilder: (context, index) {
                      final data = allModels[index];
                      final isTagMatch = data.category.toLowerCase() ==
                          categories[sealectedCategoryIndex]
                              .title
                              .toLowerCase();
                      final isTitleMatch = data.name
                          .toLowerCase()
                          .contains(searchTerm.toLowerCase());
                      final isLocationMatch = data.location
                          .toLowerCase()
                          .contains(searchTerm.toLowerCase());

                      
                      if (isTagMatch || sealectedCategoryIndex == 0) {
                        
                        if (searchTerm.isEmpty ||
                            isTitleMatch ||
                            isLocationMatch) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ItemListTileView(
                              studioModel: data,
                              onTap: () {
                                 context.push(BookingView.routePath,extra: {'id':data.id});
                              },
                            ),
                          );
                        }
                      }
                      return Container();
                      
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
    // CustomScrollView(
    //   slivers: [
    //     SliverAppBar(
    //       expandedHeight: kToolbarHeight + 20,
    //       floating: false,
    //       pinned: true,
    //       scrolledUnderElevation: 0,
    //       surfaceTintColor: ColorAssets.transparent,
    //       collapsedHeight: kToolbarHeight + 10,
    //       title: Text(
    //         "Favorite",
    //         style: textTheme.titleLarge!.copyWith(
    //           fontWeight: FontWeight.w600,
    //           fontSize: 18,
    //         ),
    //       ),
    //       centerTitle: true,
    //       actions: [
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 0),
    //           child: GestureDetector(
    //             onTap: toggleSearchBar,
    //             child: CircleAvatar(
    //               backgroundColor: colorScheme.secondary,
    //               child: const Icon(
    //                 Icons.search,
    //               ),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(width: 10)
    //       ],
    //       bottom: PreferredSize(
    //           preferredSize: Size.fromHeight(showsSearchBar ? 100 : 40),
    //           child: Column(
    //             children: [
    //               showsSearchBar
    //                   ? Padding(
    //                       padding: const EdgeInsets.symmetric(horizontal: 15),
    //                       child: FormTextField(
    //                         initialValue: searchTerm,
    //                         onChanged: changeSearchText,
    //                         suffixIcon: IconButton(
    //                             onPressed: () {
    //                               searchTerm = '';
    //                               setState(() {});
    //                             },
    //                             icon: const Icon(Icons.clear)),
    //                         hintText: "Search..",
    //                       ),
    //                     )
    //                   : const SizedBox.shrink(),
    //               Container(
    //                 height: 30.0,
    //                 margin: const EdgeInsets.symmetric(vertical: 10),
    //                 child: ListView.builder(
    //                   scrollDirection: Axis.horizontal,
    //                   itemCount: categories.length,
    //                   itemBuilder: (context, index) {
    //                     return Container(
    //                       height: 29,
    //                       margin: EdgeInsets.only(left: index == 0 ? 20 : 15),
    //                       padding: const EdgeInsets.symmetric(
    //                           horizontal: 17, vertical: 6),
    //                       decoration: BoxDecoration(
    //                           color: sealectedCategoryIndex == index
    //                               ? colorScheme.primary
    //                               : ColorAssets.lightBlueGray,
    //                           borderRadius: BorderRadius.circular(20)),
    //                       child: Text(
    //                         categories[index],
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.w600,
    //                             fontSize: 14,
    //                             color: sealectedCategoryIndex == index
    //                                 ? ColorAssets.white
    //                                 : ColorAssets.lightGray),
    //                       ),
    //                     ).onTap(() {
    //                       setState(() {
    //                         sealectedCategoryIndex = index;
    //                       });
    //                     });
    //                   },
    //                 ),
    //               ),
    //             ],
    //           )),
    //     ),
    //     SliverPadding(
    //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //       sliver: SliverList.builder(
    //         itemCount: allModels.length,
    //         itemBuilder: (context, index) {
    //           final data = allModels[index];
    //           final isCategorySelected = sealectedCategoryIndex == 0;
    //           final isTagMatch = data.tag.toLowerCase() ==
    //               categories[sealectedCategoryIndex].toLowerCase();
    //           final isTitleMatch =
    //               data.title.toLowerCase().contains(searchTerm.toLowerCase());
    //           final isLocationMatch = data.location
    //               .toLowerCase()
    //               .contains(searchTerm.toLowerCase());

    //           if (isCategorySelected || isTagMatch) {
    //             if (searchTerm.isEmpty || isTitleMatch || isLocationMatch) {
    //               return Container(
    //                 padding: EdgeInsets.only(
    //                   top: index == 0 ? 0 : 20,
    //                 ),
    //                 child: ItemListTileView(studioModel: data),
    //               );
    //             }
    //           }

    //           return null;
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }

  void changeSearchText(String text) {
    searchTerm = text;
    setState(() {});
  }
}
