import 'package:custom_widgets/progress_button/progress_button.dart';
import 'package:flutter/material.dart';

class ProgressButtonView extends StatefulWidget {
  const ProgressButtonView({Key? key}) : super(key: key);

  @override
  State<ProgressButtonView> createState() => _ProgressButtonViewState();
}

class _ProgressButtonViewState extends State<ProgressButtonView> {

  ButtonState buttonState = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Progress Button"),),
      body: Center(
        child: ProgressButton(
          state: buttonState,
          idleBtnText: "Idle",
          failBtnText: "Failed",
          successBtnText: "Success",
          onPressed: () async {
            setState(() { buttonState = ButtonState.loading; });
            await Future.delayed(Duration(seconds: 1));
            setState(() { buttonState = ButtonState.success; });
            await Future.delayed(Duration(seconds: 1));            
            setState(() { buttonState = ButtonState.fail; });
            await Future.delayed(Duration(seconds: 1));
            setState(() { buttonState = ButtonState.idle; });
          },
        ),
      ),
    );
  }
}