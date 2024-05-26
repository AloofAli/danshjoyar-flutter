import 'package:danshjoyar/classa.dart';
import 'package:danshjoyar/kara.dart';
import 'package:danshjoyar/khabara.dart';
import 'package:danshjoyar/sara.dart';
import 'package:danshjoyar/tamrina.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class changer extends StatelessWidget {
  String username;

  String password;

   changer({required this.username,required this.password,super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            labelColor: Colors.cyan,
            indicatorColor: Colors.cyanAccent,
            tabs: [Tab(icon:Icon(CupertinoIcons.home)),  Tab(icon: Icon(Icons.task_outlined)),Tab(icon:Icon(Icons.class_)),Tab(icon:Icon(CupertinoIcons.news)), Tab(icon: Icon(CupertinoIcons.pen))],
          ),
          body: TabBarView(
            children: [
              sara(),
              kara(),
              classa(),
              khabara(),
              tamrina()
            ],
          ),
        ),
      ),
    );
  }
}

