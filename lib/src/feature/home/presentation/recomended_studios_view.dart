import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/booking_view.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/item_list_tile_view.dart';
import 'package:go_router/go_router.dart';

class RecommendedStudiosView extends StatefulWidget {
  static String routePath = '/recomended-by-studios';

  final List<StudioModel> studios;
  const RecommendedStudiosView({super.key, required this.studios});

  @override
  State<RecommendedStudiosView> createState() => _RecommendedStudiosViewState();
}

class _RecommendedStudiosViewState extends State<RecommendedStudiosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
  title:  "Recomended Studio",
  leadingCallback: () => Navigator.pop(context),

      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: widget.studios.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final data = AppData.recomendedStudios[index];
            return Container(
              padding: EdgeInsets.only(
                top: index == 0 ? 0 : 20,
              ),
              child: ItemListTileView(studioModel: data,onTap: () {
                context.push(BookingView.routePath,extra: {'id':data.id});
              },),
            );
          },
        ),
      ),
    );
  }
}
