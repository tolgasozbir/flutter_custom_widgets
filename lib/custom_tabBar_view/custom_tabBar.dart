import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    Key? key, 
    required this.tabCount,
    required this.tabs,
    required this.tabBarViews, 
    this.tabBarWidth = 300, 
    this.tabBarHeight = 50, 
    this.tabBarBackgroundColor = const Color(0x552B2B2B), 
    this.tabBarRadius = 25, 
    this.labelColor = const Color(0xFFFFCC00), 
    this.unselectedLabelColor = Colors.black, 
    this.indicatorColor = Colors.white, 
    this.indicatorRadius = 25,
  }) : super(key: key);

  final int tabCount;
  final List<Widget> tabs;
  final List<Widget> tabBarViews;
  final double tabBarWidth;
  final double tabBarHeight;
  final Color tabBarBackgroundColor;
  final double tabBarRadius;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Color indicatorColor;
  final double indicatorRadius;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabCount, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(
          width: widget.tabBarWidth,
          height: widget.tabBarHeight,
          decoration: BoxDecoration(
            color: widget.tabBarBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(widget.tabBarRadius)),
          ),
          child: tabBarTabs(),
        ),
        tabBarViews(),
      ],
    );
  }

  Padding tabBarTabs() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TabBar(
        controller: tabController,
        labelColor: widget.labelColor,
        unselectedLabelColor: widget.unselectedLabelColor,
        indicator: BoxDecoration(
          color: widget.indicatorColor,
          borderRadius: BorderRadius.circular(widget.indicatorRadius)
        ),
        tabs: widget.tabs
      ),
    );
  }

  Expanded tabBarViews() {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: widget.tabBarViews
      ),
    );
  }
  
}