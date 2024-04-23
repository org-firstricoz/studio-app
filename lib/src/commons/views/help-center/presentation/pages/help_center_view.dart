import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/bloc/help_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/pages/contact_us_tab.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/pages/faq_tab.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/sliverAppbarwithSearchbar.dart';
import 'package:go_router/go_router.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class HelpCenterView extends StatefulWidget {
  static String routePath = '/help-center-view';
  const HelpCenterView({super.key});

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> {
  ScrollController scrollController = ScrollController();
  bool _isSliverAppBarExpanded = false;
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      setState(() {
        _isSliverAppBarExpanded =
            (scrollController.hasClients && scrollController.offset > 10);
      });
    });
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      // backgroundColor: ColorAssets.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppbarwithSearchBar(
                context: context,
                isSliverAppBarExpanded: _isSliverAppBarExpanded,
                controller: controller,
                title: "Help Center",
                onSubmit: (text) {
                  context
                      .read<HelpBloc>()
                      .add(GetHelpDataEvent(noParams: text));
                },
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: color.primary,
                    indicator: UnderlineTabIndicator(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 6.0,
                          color: color.primary,
                        ),
                        insets: const EdgeInsets.symmetric(horizontal: 66.0)),
                    indicatorWeight: 6,
                    unselectedLabelColor: ColorAssets.lightGray,
                    labelColor: color.primary,
                    tabs: const [
                      Tab(text: "FAQ"),
                      Tab(text: "Contact Us"),
                    ],
                  ),
                ),
                pinned: true,
                floating: false,
              ),
              // _chatsBuilder(),
            ];
          },
          body: const TabBarView(children: [
            FaqTab(),
            ContactUsTab(),
          ]),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
