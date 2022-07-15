import 'package:custom_widgets/page_ripple_transition/other_page_view.dart';
import 'package:custom_widgets/page_ripple_transition/ripple.dart';
import 'package:flutter/material.dart';

class RippleView extends StatefulWidget {
  const RippleView({Key? key}) : super(key: key);

  @override
  State<RippleView> createState() => _RippleViewState();
}

class _RippleViewState extends State<RippleView> {

  late final AnimationController rippleController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return RippleEffect(
      page: dummyPage(),
      controller: (rippleAnimationController){
        rippleController = rippleAnimationController;
      },
      screenHeight: MediaQuery.of(context).size.height
    );
  }

  Widget dummyPage(){
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: 40,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () async {
            rippleController.forward();
            await Future.delayed(Duration(seconds: 1),() {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> OtherPageView()));
            });
            rippleController.reverse();
          },
          child: Card(
            color: Colors.primaries[index%Colors.primaries.length].shade300,
          ),
        );
      },
    );
  }

  
}