import 'package:danshjoyar/pages/Signup%20page.dart';
import 'package:danshjoyar/pages/loginpage.dart';
import 'package:flutter/material.dart';

class DaneshjoyarApp extends StatelessWidget {
  const DaneshjoyarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            labelColor: Colors.cyan,
            indicatorColor: Colors.cyanAccent,
            tabs: [Tab(icon: Icon(Icons.login)), Tab(icon: Icon(Icons.add))],
          ),
          body: TabBarView(
            children: [
              LoginPage(),
              SignUpPage(),
            ],
          ),
        ),
      ),
    );
  }
}
