import 'package:custom_widgets/page_wave_transition/first_page_view.dart';
import 'package:custom_widgets/test/card.dart';
import 'package:custom_widgets/test/cardprovider.dart';
import 'package:provider/provider.dart';
import 'alphabetic_list_page_view/alphabetic_list_view.dart';
import 'progress_button/progress_button_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CardProvider()),
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
        "/card": (context) => MyCArd(),
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
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, "/progress_button"), 
            child: Text("Progress Button")
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, "/alphabetic_list_view"), 
            child: Text("Alphabetic List")
          ),          
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, "/page_wave_transition"), 
            child: Text("Page Wave Transition")
          ),         
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, "/card"), 
            child: Text("Page")
          ),
        ],
      ),
    );
  }
}