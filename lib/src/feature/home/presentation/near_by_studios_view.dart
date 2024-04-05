import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/booking_view.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/item_list_tile_view.dart';
import 'package:go_router/go_router.dart';


class NearbyStudiosView extends StatefulWidget {
  static String routePath = '/near-by-studios';
  final List<StudioModel> studios;

  const NearbyStudiosView({super.key, required this.studios});

  @override
  State<NearbyStudiosView> createState() => _NearbyStudiosViewState();
}

class _NearbyStudiosViewState extends State<NearbyStudiosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      appBar: SimpleAppBar(
        title: "Nearby Studio",
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
            final data = widget.studios[index];
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
