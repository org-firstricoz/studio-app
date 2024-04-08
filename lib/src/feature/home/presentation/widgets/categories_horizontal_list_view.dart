import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/presentation/bloc/search_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/presentation/pages/search_results_view.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:go_router/go_router.dart';

class CategoriesHorizontalListView extends StatefulWidget {
  const CategoriesHorizontalListView({super.key});

  @override
  State<CategoriesHorizontalListView> createState() =>
      _CategoriesHorizontalListViewState();
}

class _CategoriesHorizontalListViewState
    extends State<CategoriesHorizontalListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 85,
      width: double.maxFinite,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: index == 0 ? 24 : 30),
            child: Column(
              children: [
                Image.network(
                  AppData.categories[index].image,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
                // const SizedBox(height: 10),
                const Spacer(),
                Text(
                  AppData.categories[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ).onTap(() {
            context.read<SearchBloc>().add(
                GetSearchResultsEvent(query: AppData.categories[index].title));
            context.push(SearchResultsView.routePath,
                extra: {"query": AppData.categories[index].title});
          });
        },
        itemCount: AppData.categories.length,
      ),
    );
  }
}
