import 'package:custom_widgets/page_wave_transition/second_page_view.dart';
import 'package:flutter/material.dart';

class FirstPageView extends StatefulWidget {
  const FirstPageView({Key? key}) : super(key: key);

  @override
  State<FirstPageView> createState() => _FirstPageViewState();
}

class _FirstPageViewState extends State<FirstPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      floatingActionButton: fabButton(),
      body: _bodyView(),
    );
  }

  FloatingActionButton fabButton() {
    return FloatingActionButton(
      onPressed: () => Navigator.push(context, PageRouteBuilder(opaque: false, pageBuilder: (_,__,___) => SecondPageView())),
      child: Icon(Icons.rocket_launch_outlined),
    );
  }

  Widget _bodyView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 16/9
      ),
      itemCount: 16,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.primaries[index%Colors.primaries.length],
        );
      },
    );
  }
}

