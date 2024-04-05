// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';

class GalleryTab extends StatefulWidget {
  final StudioDetails studioDetails;
  const GalleryTab({
    Key? key,
    required this.studioDetails,
  }) : super(key: key);

  @override
  State<GalleryTab> createState() => _GalleryTabState();
}

class _GalleryTabState extends State<GalleryTab> {
  @override
  void initState() {
    super.initState();
  }

  // List<String> studioImageLinks = [
  //   'https://picsum.photos/800/800?image=1032',
  //   'https://picsum.photos/800/800?image=1033',
  //   'https://picsum.photos/800/800?image=1035',
  //   'https://picsum.photos/800/800?image=1036',
  //   'https://picsum.photos/800/800?image=1037',
  //   'https://picsum.photos/800/800?image=1038',
  //   'https://picsum.photos/800/800?image=1039',
  //   'https://picsum.photos/800/800?image=1040',
  //   'https://picsum.photos/800/800?image=1032',
  //   'https://picsum.photos/800/800?image=1033',
  //   'https://picsum.photos/800/800?image=1035',
  //   'https://picsum.photos/800/800?image=1036',
  //   'https://picsum.photos/800/800?image=1037',
  //   'https://picsum.photos/800/800?image=1038',
  //   'https://picsum.photos/800/800?image=1039',
  //   'https://picsum.photos/800/800?image=1040',
  // ];

  ///[
  ///   'https://www.kasandbox.org/programming-images/avatars/spunky-sam.png',
  /// 'https://www.kasandbox.org/programming-images/avatars/spunky-sam-green.png',
  /// 'https://www.kasandbox.org/programming-images/avatars/purple-pi.png',
  ///    'https://www.kasandbox.org/programming-images/avatars/purple-pi-teal.png',
  ///  'https://www.kasandbox.org/programming-images/avatars/purple-pi-pink.png',
  /// 'https://www.kasandbox.org/programming-images/avatars/primosaur-ultimate.png',
  ///  'https://www.kasandbox.org/programming-images/avatars/primosaur-tree.png',
  ///   'https://www.kasandbox.org/programming-images/avatars/primosaur-sapling.png',
  /// 'https://www.kasandbox.org/programming-images/avatars/orange-juice-squid.png',
  ///  'https://www.kasandbox.org/programming-images/avatars/old-spice-man.png',
  /// 'https://www.kasandbox.org/programming-images/avatars/old-spice-man-blue.png',
  ///  'https://www.kasandbox.org/programming-images/avatars/mr-pants.png',
  /// 'https://www.kasandbox.org/programming-images/avatars/mr-pants-purple.png',
  ///  'https://www.kasandbox.org/programming-images/avatars/mr-pants-green.png',
  ///   'https://www.kasandbox.org/programming-images/avatars/marcimus.png',
  ///  'https://www.kasandbox.org/programming-images/avatars/marcimus-red.png',
  /// 'https://www.kasandbox.org/programming-images/avatars/marcimus-purple.png',
  /// 'https://www.kasandbox.org/programming-images/avatars/marcimus-orange.png',
  /// 'https://www.kasandbox.org/programming-images/avatars/duskpin-ultimate.png',
  ///  'https://www.kasandbox.org/programming-images/avatars/duskpin-tree.png',
  ///  'https://www.kasandbox.org/programming-images/avatars/duskpin-seedling.png',
  ///  'https://www.kasandbox.org/programming-images/avatars/duskpin-seed.png',
  ///  'https://www.kasandbox.org/programming-images/avatars/duskpin-sapling.png',
  /// ]

  GalleryTab get studioImages => widget;

  @override
  Widget build(BuildContext context) {
    final studioImageLinks = widget.studioDetails.gallery;
    return GridView.custom(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: studioImageLinks.length,
        (context, index) => InkWell(
          onTap: () => _showImagePopup(studioImageLinks[index]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: studioImageLinks[index],
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Text(""),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePopup(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: AspectRatio(
          aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Text(""),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
