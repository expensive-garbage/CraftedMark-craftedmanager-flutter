import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshableListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Future<void> Function() onRefresh;

  const RefreshableListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          // Use Material design refresh for Android devices or larger displays
          return _androidListView();
        } else {
          // Use Cupertino design refresh for iOS devices
          return _iOSListView();
        }
      },
    );
  }

  Widget _iOSListView() {
    return CupertinoScrollbar(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
          SliverSafeArea(
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                itemBuilder,
                childCount: itemCount,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _androidListView() {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
