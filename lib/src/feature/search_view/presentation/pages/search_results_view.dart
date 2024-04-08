import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/booking_view.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/presentation/bloc/search_bloc.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/item_list_tile_view.dart';
import 'package:go_router/go_router.dart';

class SearchResultsView extends StatefulWidget {
  static String routePath = '/search-results-view';
  final String searchTerm;
  const SearchResultsView({super.key, required this.searchTerm});

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  @override
  void initState() {
    print(widget.searchTerm);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: widget.searchTerm,
        centerTitle: false,
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SearchFailureState) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator(), Text('Searching...')],
              ),
            );
          }
          if (state is SearchSuccessState) {
            return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                itemCount: AppData.searchResult.length,
                itemBuilder: (context, index) {
                  if (AppData.searchResult.isNotEmpty) {
                    final data = AppData.searchResult[index];
                    print(data);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ItemListTileView(
                        studioModel: data,
                        onTap: () {
                          context.push(BookingView.routePath,
                              extra: {'id': data.id});
                        },
                      ),
                    );
                  }
                });
          } else if (state is FilterSuccessState) {
            return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                itemCount: state.models.length,
                itemBuilder: (context, index) {
                  if (AppData.filterResult.isNotEmpty) {
                    final data = AppData.filterResult[index];
                    print(data);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ItemListTileView(
                        studioModel: data,
                        onTap: () {
                          context.push(BookingView.routePath,
                              extra: {'id': data.id});
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('No Studio Available'),
                    );
                  }
                });
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
