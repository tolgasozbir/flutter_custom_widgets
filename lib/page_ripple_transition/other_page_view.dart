import 'package:flutter/material.dart';

class OtherPageView extends StatefulWidget {
  const OtherPageView({Key? key}) : super(key: key);

  @override
  State<OtherPageView> createState() => _OtherPageViewState();
}

class _OtherPageViewState extends State<OtherPageView> with SingleTickerProviderStateMixin {

  late final AnimationController _fadeAnimationController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeAnimationController = AnimationController(vsync: this,duration: Duration(seconds: 1));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1).animate(_fadeAnimationController);
    _fadeAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: dummyView(),
    );
  }

    Widget dummyView(){
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