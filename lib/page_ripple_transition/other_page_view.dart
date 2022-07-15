import 'package:flutter/material.dart';

class OtherPageView extends StatefulWidget {
  const OtherPageView({Key? key}) : super(key: key);

  @override
  State<OtherPageView> createState() => _OtherPageViewState();
}

class _OtherPageViewState extends State<OtherPageView> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Center(child: Text(index.toString())),
          color: Colors.primaries[index%Colors.primaries.length].shade300,
        );
      },
    );
  }

}