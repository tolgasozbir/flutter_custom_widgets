import 'package:custom_widgets/custom_tabBar_view/custom_tabBar.dart';
import 'package:flutter/material.dart';

part 'dummy_page.dart';

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({Key? key}) : super(key: key);

  @override
  State<CustomTabBarView> createState() => _MyLoginState();
}

class _MyLoginState extends State<CustomTabBarView> with AutomaticKeepAliveClientMixin<CustomTabBarView> {

  List<Widget> pages = [
    DummyPage(PageNum: 1, color: Colors.orange),
    DummyPage(PageNum: 2, color: Colors.pink),
  ];

  List<Widget> tabs = [
    SizedBox.expand(child: Center(child: Text("Page 1"))),
    SizedBox.expand(child: Center(child: Text("Page 2"))),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text("Custom TabBar Outside of AppBar"),),
      body: body(),
    );
  }

  Widget body(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTabBar(
        tabCount: pages.length, 
        tabs: tabs,
        tabBarViews: pages
      ),
    );
  }
 


}