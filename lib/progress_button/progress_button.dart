import 'package:flutter/material.dart';

enum ButtonState { idle, loading, success, fail }

class ProgressButton extends StatefulWidget {

  final VoidCallback onPressed;
  final ButtonState state;
  final double width;
  final double height;
  final double indicatorSize;
  final double radius;
  final Color color;
  final TextStyle? textStyle;
  final Duration animationDuration;
  final double padding;
  final String idleBtnText;
  final String failBtnText;
  final String successBtnText;
  final IconData? idleBtnIcon;
  final IconData? failBtnIcon;
  final IconData? successBtnIcon;
  final Color loadingColor;
  final Color failColor;
  final Color successColor;
  

  ProgressButton({
    Key? key,
    required this.onPressed,
    required this.state,
    this.width = 200,
    this.height = 50,
    this.indicatorSize = 35,
    this.radius = 8,
    this.color = Colors.deepPurple,
    this.textStyle,
    this.animationDuration = const Duration(milliseconds: 500),
    this.padding = 4,
    required this.idleBtnText,
    required this.failBtnText,
    required this.successBtnText,
    this.idleBtnIcon = Icons.send,
    this.failBtnIcon = Icons.cancel,
    this.successBtnIcon = Icons.check_circle,
    this.loadingColor = Colors.deepPurple,
    this.failColor = Colors.red,
    this.successColor = Colors.green
  }) : super(key: key);

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> {

  TextStyle textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w500);

  @override
  void didUpdateWidget(covariant ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      setState(() { });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: widget.height,
      duration: widget.animationDuration,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),
        color: widget.state == ButtonState.idle 
          ? widget.color
          : widget.state == ButtonState.fail
            ? widget.failColor
            : widget.state == ButtonState.success
              ? widget.successColor
              : widget.loadingColor
      ),
      child: TextButton(
        onPressed: (){
          if (widget.state != ButtonState.idle) return;
          else widget.onPressed();
        },
        child: widget.state == ButtonState.idle 
          ? _iconText(widget.state) 
          : widget.state == ButtonState.fail
            ? _iconText(widget.state) 
            : widget.state == ButtonState.success
              ? _iconText(widget.state) 
              : _progressIndicator(),
      ),
    );
  }

  Row _iconText(ButtonState buttonState){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          buttonState == ButtonState.idle 
            ? widget.idleBtnIcon 
            : buttonState == ButtonState.fail 
              ? widget.failBtnIcon 
              : widget.successBtnIcon ,
          color: Colors.white,
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: widget.padding)),
        Text(
          buttonState == ButtonState.idle 
            ? widget.idleBtnText 
            : buttonState == ButtonState.fail 
              ? widget.failBtnText 
              : widget.successBtnText ,
          style: widget.textStyle ?? textStyle
        )
      ],
    );
  }  
  
  SizedBox _progressIndicator(){
    return SizedBox(
      width: widget.indicatorSize,
      height: widget.indicatorSize,
      child: CircularProgressIndicator()
    );
  }

}