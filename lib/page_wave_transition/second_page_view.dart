import 'package:custom_widgets/page_wave_transition/wave_transition.dart';
import 'package:flutter/material.dart';

class SecondPageView extends StatefulWidget {
  const SecondPageView({Key? key}) : super(key: key);

  @override
  State<SecondPageView> createState() => _SecondPageViewState();
}

class _SecondPageViewState extends State<SecondPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(child: _bodyView()),
    );
  }

  Widget _bodyView() {
    return WaveTransition(
      duration: Duration(milliseconds: 1500), 
      fractionalOffset: FractionalOffset(0.90, 0.95), 
      child: _body()
    );
  }

  Widget _body() {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.black),
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return emptyCard(index);
          },
        ),
      ),
    );
  }

  Widget emptyCard(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: AspectRatio(
        aspectRatio: 16/9,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.primaries[index%Colors.primaries.length])
          ),
        )
      ),
    );
  }
}

