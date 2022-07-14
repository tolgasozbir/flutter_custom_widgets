import 'package:custom_widgets/custom_clip_button/clipped_button.dart';
import 'package:flutter/material.dart';

class ClippedButtonView extends StatefulWidget {
  const ClippedButtonView({Key? key}) : super(key: key);

  @override
  State<ClippedButtonView> createState() => _ViewState();
}

class _ViewState extends State<ClippedButtonView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Clipped Button"),),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Column(
      children: [
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClippedButton(
              onTap: () => print("Helloo!"),
              buttonSide: ButtonSide.left,
              color: Color(0xFFA0A0A0),
              icon: Icon(Icons.close,size: 40,color: Colors.white,),
            ),
            Icon(Icons.replay_outlined,size: 52,),
            Icon(Icons.star_border,size: 52,),
            Icon(Icons.sync_lock_sharp,size: 52,),
            ClippedButton(
              onTap: () => print("Holaa!"),
              buttonSide: ButtonSide.right,
              color: Colors.red,
              icon: Icon(Icons.favorite,size: 40,color: Colors.white,),
            ),
          ],
        ),
      ],
    );
  }
}