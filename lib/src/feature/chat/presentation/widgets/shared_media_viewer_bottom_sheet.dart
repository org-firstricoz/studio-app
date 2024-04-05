part of '../pages/user_chat_profile.dart';

class SharedChatMediaBottomSheet extends StatefulWidget {
  const SharedChatMediaBottomSheet({super.key, required this.media});
  final List<String> media;

  @override
  State<SharedChatMediaBottomSheet> createState() =>
      _SharedChatMediaBottomSheetState();
}

class _SharedChatMediaBottomSheetState
    extends State<SharedChatMediaBottomSheet> {
  @override
  Widget build(BuildContext context) {
    List<String> studioImageLinks = widget.media;
    // [
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

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.3, // Initial size when fully collapsed
      minChildSize: 0.1, // Minimum size when partially collapsed
      maxChildSize: 1, // Maximum size when fully expanded
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          // color: Colors.blueGrey[100],
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
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
            controller: scrollController,
            itemCount: studioImageLinks.length,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
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
              );
            },
          ),
        );
      },
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.5, // Initial size of the bottom sheet
      minChildSize: 0.25, // Minimum size when fully collapsed
      maxChildSize: 1.0,
      builder: (context, scrollController) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Expanded(
              child: GridView.custom(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
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
                    onTap: () {},
                    // onTap: () => _showImagePopup(studioImageLinks[index]),
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
              ),
            )
          ])),
    );
  }
}
