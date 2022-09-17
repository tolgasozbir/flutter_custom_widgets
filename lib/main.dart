import 'package:custom_widgets/animated_dialogs/dialogs.view.dart';
import 'package:custom_widgets/battle_card/battle_cards_provider.dart';
import 'package:custom_widgets/battle_card/battle_screen_view.dart';
import 'package:custom_widgets/custom_clip_button/clipped_button_view.dart';
import 'package:custom_widgets/custom_tabBar_view/custom_tabBar_view.dart';
import 'package:custom_widgets/page_ripple_transition/ripple_view.dart.dart';
import 'package:custom_widgets/page_wave_transition/first_page_view.dart';
import 'package:custom_widgets/parallax_effect/parallax_view.dart';
import 'package:provider/provider.dart';
import 'alphabetic_list_page_view/alphabetic_list_view.dart';
import 'progress_button/progress_button_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BattleCardProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(appBarTheme: AppBarTheme(centerTitle: true)),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/progress_button": (context) => ProgressButtonView(),
        "/alphabetic_list_view": (context) => AlphabeticListView(),
        "/page_wave_transition": (context) => FirstPageView(),
        "/battle_cards": (context) => BattleScreenView(),
        "/custom_tabBar": (context) => CustomTabBarView(),
        "/custom_clipped_button": (context) => ClippedButtonView(),
        "/page_ripple_transition": (context) => RippleView(),
        "/parallax": (context) => ParallaxView(),
        "/animated_dialogs": (context) => DialogsView(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Widgets"),),
      body: _bodyView(),
    );
  }

  Widget _bodyView(){
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          routeBtn(routeName: '/progress_button', title: 'Progress Button'),
          routeBtn(routeName: '/alphabetic_list_view', title: 'Alphabetic List'),
          routeBtn(routeName: '/page_wave_transition', title: 'Wave Transition'),
          routeBtn(routeName: '/battle_cards', title: 'Battle Cards'),
          routeBtn(routeName: '/custom_tabBar', title: 'Custom TabBar View'),
          routeBtn(routeName: '/custom_clipped_button', title: 'Custom Button Clip'),
          routeBtn(routeName: '/page_ripple_transition', title: 'Ripple Transition'),
          routeBtn(routeName: '/parallax', title: 'Parallax Effect'),
          routeBtn(routeName: '/animated_dialogs', title: 'Animated Dialogs'),
        ],
      ),
    );
  }

  ElevatedButton routeBtn({required String routeName, required String title, Object? arguments,}){
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, routeName), 
      child: Text(title)
    );
  }

}