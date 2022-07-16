import 'package:custom_widgets/parallax_effect/parallax.dart';
import 'package:flutter/material.dart';

class ParallaxView extends StatefulWidget {
  const ParallaxView({Key? key}) : super(key: key);

  @override
  State<ParallaxView> createState() => PparallaxViewState();
}

class PparallaxViewState extends State<ParallaxView> {

  List<String> listOfImages = [
    "https://picsum.photos/450/300?random=10",
    "https://picsum.photos/450/300?random=20",
    "https://picsum.photos/450/300?random=30",
    "https://picsum.photos/450/300?random=40",
    "https://picsum.photos/450/300?random=50",
    "https://picsum.photos/450/300?random=60",
    "https://picsum.photos/450/300?random=70",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parallax Effect"),),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Parallax(
      viewportFraction: 0.7,
      isFromAssetsImages: false,
      parallaxImages: listOfImages
    );
  }
}