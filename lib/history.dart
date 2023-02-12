import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HistoryScreen extends StatefulWidget {
  //const HomeScreen({key? key}) : super(key: key);
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.black38,

            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyLight.chat,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}