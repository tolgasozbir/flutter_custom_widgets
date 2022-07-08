import 'dart:convert';
import 'alphabetic_list_view.dart';
import 'user_model.dart';
import 'package:flutter/material.dart';

abstract class AlphabeticListViewModel extends State<AlphabeticListView> {
  bool isLoading = false;
  bool visible = false;
  List<User> userList = [];
  List<User> userListSearch = [];
  List<String> firstLetters = [];
  int selectedLetterIndex = 0;
  TextStyle selected = TextStyle(fontSize: 22,color: Colors.blue,fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    init();
  }

  void changeLoading(){
    setState(() {   
      isLoading = !isLoading;
    });
  }

  Future<void> init() async {
    changeLoading();
    await getUsers();
    await getFirstLetters();
    await Future.delayed(Duration(seconds: 1));
    changeLoading();
  }

  Future<void> getUsers() async {
    var assetBundle = DefaultAssetBundle.of(context);
    var data = await assetBundle.loadString("assets/users.json");
    userList = (jsonDecode(data) as List).map((e) => User.fromJson(e)).toList();
    userListSearch = userList;
  }

  Future<void> getFirstLetters() async {
    var letters = await userList.map((e) => e.fullName.trim()[0].toUpperCase()).toSet().toList();
    letters.sort();
    firstLetters = letters;
    firstLetters.insert(0, "All");
  }

  void buildLetters(int index){
    if (index == 0) {
      userListSearch = userList;
    }else{
      userListSearch = userList.where((element) {
        return firstLetters[index] == element.fullName.trim()[0];
      }).toList();
    }
  }

}