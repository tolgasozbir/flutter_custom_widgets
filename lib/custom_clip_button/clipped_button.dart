import 'package:flutter/material.dart';

part 'button_clipper.dart';

enum ButtonSide {left, right}

class ClippedButton extends StatefulWidget {
  const ClippedButton({
    Key? key, 
    this.color = Colors.blue, 
    this.width = 60, 
    this.height = 150,
    required this.buttonSide, 
    this.icon,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final double width;
  final double height;
  final ButtonSide buttonSide;
  final Icon? icon;
  final VoidCallback? onTap;

  @override
  State<ClippedButton> createState() => _ClippedButtonState();
}

class _ClippedButtonState extends State<ClippedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.onTap,
      child: Stack(
        children: [
          RotatedBox(
            quarterTurns: widget.buttonSide == ButtonSide.left ? 0 : 2,
            child: ClipPath(
              clipper: CustomButtonClip(),
              child: Container(
                color: widget.color,
                width: widget.width,
                height: widget.height,
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: widget.buttonSide == ButtonSide.left ? 6 : -6,
            left: 0,
            right: widget.buttonSide == ButtonSide.left ? 8 : -8,
            child: widget.icon ?? SizedBox.shrink()
          )
        ],
      ),
    );
  }


}