import 'package:custom_widgets/animated_dialogs/dialogs.dart';
import 'package:flutter/material.dart';

class DialogsView extends StatelessWidget {
  const DialogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(context),
    );
  }
  //TODO: Tüm kombinasyonlar gösterilcek
  SizedBox _bodyView(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text("Animated Dialog"),
            onPressed: (){
              showAnimatedDialog(
                context: context, 
                duration: Duration(milliseconds: 600),
                slidePosition: SlidePosition.center, 
                fading: true,
                scaleY: true,
                scaleX: false,
                dialogPageContent: dialogView(),
              );
            }
          ),    
        ],
      ),
    );
  }

  Widget dialogView(){
    return Container(
      height: 200,
      width: 200,
      color: Colors.amber,
      child: Text("Holaaa"),
    );
  }
}