import 'dart:async';
import 'package:flutter/material.dart';
import 'alphabetic_list_view_model.dart';
import 'user_card.dart';

class AlphabeticListView extends StatefulWidget {
  const AlphabeticListView({Key? key,}) : super(key: key);

  @override
  State<AlphabeticListView> createState() => _AlphabeticListViewState();
}

class _AlphabeticListViewState extends AlphabeticListViewModel {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alphabetic Page View")),
      body: isLoading ? loading() : bodyView());
  }

  Center loading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget bodyView() {
    return Stack(
      children: [
        Row(
          children: [
            page(),
            letters(),
          ],
        ),
        showPreview(firstLetters[selectedLetterIndex]),
      ],
    );
  }

  Expanded letters() {
    return Expanded(
      child: Column(
        children: [
          Spacer(),
          Expanded(
            flex: 2,
            child: PageView.builder(
              physics: PageScrollPhysics(),
              onPageChanged: (int value) {
                setState(() {
                  selectedLetterIndex = value; 
                  buildLetters(value);
                  visible=true;
                });
                Timer(Duration(seconds: 2), () {
                  setState(() {
                    visible = false;
                  });
                });
              },
              controller: PageController(viewportFraction: .1),
              scrollDirection: Axis.vertical,
              itemCount: firstLetters.length,
              itemBuilder: (context, index) {
                return Center(child: Text(firstLetters[index],style: selectedLetterIndex == index ? selected : null,));
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Expanded page() {
    return Expanded(
      flex: 9,
      child: Padding(
        padding: const EdgeInsets.only(left: 8,top: 8),
        child: ListView.builder(
          itemCount: userListSearch.length,
          itemBuilder: (context,index){
            return UserCard(user: userListSearch[index],index: index,);
          }
        ),
      ),
    );
  }

  Widget showPreview(String textview){
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Container(
            width: 160,
            height: 160,
            color: Colors.black54,
            child: Center(child: Text("$textview",style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold))),
          ),
        ),
      ),
    );
  }
}

