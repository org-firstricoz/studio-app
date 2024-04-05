import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/booking_view.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/views/book_tour_view.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/views/tour_request_view.dart';
import 'package:flutter_riverpod_base/src/feature/settings/provider/theme_provider.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/utils/functions.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/item_list_tile_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:latlong2/latlong.dart';
import '../widgets/custom_search_bar.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(latitude, longitude),
            initialZoom: 15.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            CircleLayer(circles: [
              CircleMarker(
                  point: LatLng(latitude, longitude),
                  radius: 10,
                  color: Colors.blue),
              CircleMarker(
                  point: LatLng(latitude, longitude),
                  radius: 500,
                  useRadiusInMeter: true,
                  color: Colors.blue.withOpacity(0.2))
            ]),
            MarkerLayer(markers: _listOfMarkers()
                // [
                //   Marker(
                //       height: 50,
                //       width: 50,
                //       point: LatLng(latitude, longitude + 0.002),
                //       child: GestureDetector(
                //         onTap: () {
                //           print('clicked on icon');
                //         },
                //         child: pointerForStudio(),
                //       ))
                // ],
                ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(
                      Uri.parse('https://openstreetmap.org/copyright')),
                ),
              ],
            ),
          ],
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildSearchbar(),
              const Spacer(),
              _buildNearbyLocations(),
            ],
          ),
        ),
      ],
    );
  }

  pointerForStudio(String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.red, width: 2),
                color: Colors.red,
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          Icon(
            Icons.location_on,
            color: Colors.red.withOpacity(0.8),
          ),
        ],
      ),
    );
  }

  List<Marker> _listOfMarkers() {
    final List<Marker> list = [];
    final listOfnearByStudios = AppData.nearByStudios;
    final recommendedStudios = AppData.recomendedStudios;

    for (var i in listOfnearByStudios) {
      var marker = Marker(
          height: 70,
          width: 70,
          point: LatLng(i.latitude, i.longitude),
          child: pointerForStudio(i.image, () {
            context.push(BookingView.routePath, extra: {'id': i.id});
          }));
      list.add(marker);
    }
    for (var i in recommendedStudios) {
      var marker = Marker(
          height: 70,
          width: 70,
          point: LatLng(i.latitude, i.longitude),
          child: pointerForStudio(i.image, () {
            context.push(BookingView.routePath, extra: {'id': i.id});
          }));
      list.add(marker);
    }
    return list;
  }

  _buildSearchbar() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 50,
        width: double.maxFinite,
        child: const CustomSearchBar());
  }

  _buildNearbyLocations() {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      width: double.maxFinite,
      height: 124,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppData.nearByStudios.length,
        itemBuilder: (context, index) {
          final data = AppData.nearByStudios[index];
          return Container(
            margin: const EdgeInsets.only(left: 20),
            width: 320,
            child: ItemListTileView(
              studioModel: data,
              onTap: () {
                context.push(BookingView.routePath, extra: {'id': data.id});
              },
            ),
          );
        },
      ),
    );
  }
}
