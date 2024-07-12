import 'dart:async';
import 'dart:io';

import 'package:danshjoyar/pages/EditAccount.dart';
import 'package:danshjoyar/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class sara extends StatefulWidget {
  final String username;
  final String password;

  sara({required this.username, required this.password});

  @override
  State<sara> createState() => _saraState(username, password);
}

class _saraState extends State<sara> {
  List<Task> allTasks = [];
  List<Task> doneTasks = [];
  List<String> _detail = ["", "", "", "", ""];

  @override
  void initState() {
    super.initState();
    _loaddetail(widget.username);
    _loadTasks(username);
  }

  Future<void> _loadTasks(String username) async {
    List<Task> tasks = await fetchTasks(username);
    setState(() {
      allTasks = tasks;
      print("tasks =$tasks");
    });
  }

  Future<void> removetask(String username, String name) async {
    await Socket.connect("192.168.245.1", 7777).then((serverSocket) {
      serverSocket.write('DELETETASK~$username~$name\u0000');
    });
    setState(() {
      _loadTasks(username);
    });
  }

  Future<void> _loaddetail(String username) async {
    List<String> details = await checker(username);
    print("Details fetched: $details");
    if (details.isNotEmpty) {
      setState(() {
        _detail = details;
      });
    }
  }

  Future<List<Task>> fetchTasks(String username) async {
    List<Task> tasks = [];
    Socket socket;
    try {
      socket = await Socket.connect("192.168.245.1", 7777);
      socket.write('SHOWTASKS~$username\u0000');
      await socket.flush();
      Completer<List<Task>> completer = Completer();
      socket.listen((socketResponse) {
        String result = String.fromCharCodes(socketResponse);
        List<String> splittedByLine = result.split("\n");
        for (var line in splittedByLine) {
          if (line.isNotEmpty) {
            List<String> parts = line.split("~");
            if (parts.length >= 3) {
              tasks.add(Task(parts[0], parts[1], parts[2]));
            }
          }
        }
        completer.complete(tasks);
      }).onDone(() {
        socket.destroy();
      });
      return completer.future;
    } catch (e) {
      print("Failed to fetch tasks: $e");
      return [];
    }
  }

  final String username;
  final String password;

  _saraState(this.username, this.password);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton<int>(
              iconColor: Colors.white,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      Icon(Icons.laptop_windows_sharp),
                      SizedBox(width: 10),
                      Text("Backend Github")
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 4,
                  child: Row(
                    children: [
                      Icon(Icons.laptop_windows_sharp),
                      SizedBox(width: 10),
                      Text("Frontend Github")
                    ],
                  ),
                ),
              ],
              color: Colors.white,
              onSelected: (value) {
                if (value == 3) {
                  _launchURL(
                      Uri.parse('https://github.com/Aminxh/danshjooyar_back'));
                } else if (value == 4) {
                  _launchURL(Uri.parse(
                      'https://github.com/AloofAli/danshjoyar-flutter'));
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.account_circle_outlined,
                size: 35,
                color: Colors.white,
              ),
              tooltip: 'Open Edit Account',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profileScreen(
                          username: username, password: password)),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "lib/asset/images/casey-horner-4rDCa5hBlCs-unsplash.jpg",
                    ),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black26, BlendMode.darken),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height / 50,
                  MediaQuery.of(context).size.height / 10,
                  MediaQuery.of(context).size.height / 50,
                  MediaQuery.of(context).size.height / 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary:',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSummaryBox(
                            icon: Icon(Icons.school),
                            text: "Exam:${_detail[0]}",
                            width: 110),
                        SizedBox(
                          width: 10,
                        ),
                        _buildSummaryBox(
                            icon: Icon(Icons.task),
                            text: "Deadlines:${_detail[3]}",
                            width: 120),
                        SizedBox(
                          width: 10,
                        ),
                        _buildSummaryBox(
                            icon: Icon(Icons.star),
                            text: "Best Score:${_detail[1]}",
                            width: 110),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSummaryBox(
                          icon: Icon(Icons.restore_from_trash_outlined),
                          text: "Worst Score:${_detail[2]}",
                        ),
                        _buildSummaryBox(
                          icon: Icon(Icons.done_outlined),
                          text: " Done: ${_detail[4]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TODOS:',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 200,
                          child: ListView.builder(
                            itemCount: allTasks.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white.withOpacity(0.8),
                                child: ListTile(
                                  leading: IconButton(
                                      icon: const Icon(Icons.circle_outlined),
                                      onPressed: () {
                                        setState(() {
                                          doneTasks.add(allTasks[index]);
                                          allTasks.remove(index);
                                          removetask(
                                              username, allTasks[index].name);
                                        });
                                      }),
                                  title: Text(
                                    allTasks[index].name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  subtitle: Text(allTasks[index]
                                      .dateTime
                                      .toString()
                                      .split(" ")
                                      .first),

                                ),
                              );
                            },
                          ),
                        ),
                        Text(
                          'Completed Tasks:',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 100,
                          child: ListView.builder(
                            itemCount: doneTasks.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white.withOpacity(0.5),
                                child: ListTile(
                                  leading: Icon(Icons.done),
                                  title: Text(doneTasks[index].name,
                                      style: TextStyle(fontSize: 18)),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }

  Widget _buildSummaryBox(
      {required String text, required Icon icon, double width = 130}) {
    return Container(
      width: width,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.shade200,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(
              color: Colors.black,
              size: 50,
            ),
            child: icon,
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------

  Future<List<String>> checker(String username) async {
    List<String> detail = [];
    await Socket.connect("192.168.245.1", 7777).then((serverSocket) {
      serverSocket.write('SHOWDETAIL~$username\u0000');
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        String result = String.fromCharCodes(socketResponse);
        detail = result.split('~');
        print("Server response: $detail");
        setState(() {
          _detail = detail;
        });
      });
    });

    return detail;
  }
}

// ---------------------------------------------------------------------------

class Task {
  String name = "";
  String dateTime = "";
  String description = "";

  Task(this.name, this.dateTime, this.description);
}

// ---------------------------------------------------------------------------

_launchURL(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}
