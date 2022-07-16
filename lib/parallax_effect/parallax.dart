import 'package:flutter/cupertino.dart';

class Parallax extends StatefulWidget {
  const Parallax({
    Key? key, 
    required this.parallaxImages, 
    required this.isFromAssetsImages, 
    this.viewportFraction = 0.65,
    this.scrollDirection = Axis.horizontal, 
    this.width,
    this.height = 400, 
    this.padding = const EdgeInsets.all(8.0), 
    this.radius = 15, 
  }) : assert(viewportFraction <= 1.0),
       super(key: key);

  final List<String> parallaxImages;
  final bool isFromAssetsImages;
  final double viewportFraction;
  final Axis scrollDirection;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final double radius;

  @override
  State<Parallax> createState() => _ParallaxState();
}

class _ParallaxState extends State<Parallax> {

  late final PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: widget.viewportFraction);
    pageController.addListener(() {
      setState(() => pageOffset=pageController.page!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: PageView.builder(
        itemCount: widget.parallaxImages.length,
        scrollDirection: widget.scrollDirection,
        controller: pageController,
        itemBuilder: (context, index) {
          return Padding(
            padding: widget.padding,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: widget.isFromAssetsImages ? _fromAsset(index) : _fromNetwork(index),
            ),
          );
        },
      ),
    );
  }

  Image _fromAsset(int index) {
    return Image.asset(
      widget.parallaxImages[index],
      fit: BoxFit.cover,
      alignment: widget.scrollDirection == Axis.horizontal 
        ? Alignment(-pageOffset.abs()+index, 0) 
        : Alignment(0, -pageOffset.abs()+index),
    );
  }

  Image _fromNetwork(int index) {
    return Image.network(
      widget.parallaxImages[index],
      fit: BoxFit.cover,
      alignment: widget.scrollDirection == Axis.horizontal 
        ? Alignment(-pageOffset.abs()+index, 0) 
        : Alignment(0, -pageOffset.abs()+index),
    );
  }
}