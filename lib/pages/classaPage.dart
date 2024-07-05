import 'dart:io';

import 'package:danshjoyar/pages/classaPage.dart';
import 'package:flutter/material.dart';

class classa extends StatefulWidget {
  String username;

   classa({required  this.username, super.key});

  @override
  State<classa> createState() => _classaState(username);
}

class _classaState extends State<classa> {

  String username;
  _classaState(this.username);
  List<Courses> _classes = [];
  void initState() {
    super.initState();
    _loadClasses(username);
  }
  void addClass(Courses celas) {
    setState(() {
      _classes.add(celas);
    });
  }
  Future<void> _loadClasses(String username) async {

    List<Courses> classes = await checker(username);
    setState(() {
      print("$classes");
      _classes = classes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "lib/asset/images/casey-horner-4rDCa5hBlCs-unsplash.jpg",
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.height / 25,
          MediaQuery.of(context).size.height / 10,
          MediaQuery.of(context).size.height / 25,
          MediaQuery.of(context).size.height / 25,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Your Classes",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => AddClassBottomSheet(
                        username: username,
                        addClassCallback: _loadClasses,
                      ),
                      isScrollControlled: true,
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        "Add Class",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.add,
                        color: Colors.cyan,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _classes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan.shade100,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.school,
                                    size: 30, color: Colors.cyan),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ${_classes.elementAt(index).name}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.cyan,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                             Row(
                              children: [
                                Icon(Icons.numbers,
                                    size: 20, color: Colors.cyan),
                                SizedBox(width: 8),
                                Text(
                                  "Credit: ${_classes.elementAt(index).Credit}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                             Row(
                              children: [
                                Icon(Icons.class_,
                                    size: 20, color: Colors.cyan),
                                SizedBox(width: 8),
                                Text(
                                  "Assignment:${_classes.elementAt(index).NumberOfAssignment}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                             Row(
                              children: [
                                Icon(Icons.star, size: 20, color: Colors.cyan),
                                SizedBox(width: 8),
                                Text(
                                  "Students:${_classes.elementAt(index).NumberOfStudents}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


    Future<List<Courses>> checker(String username ) async {
      List<Courses> course=[];
      await Socket.connect("172.25.144.1", 7777).then((serverSocket) {
        serverSocket
            .write('SHOWCLASS~$username\u0000');
        serverSocket.flush();
        serverSocket.listen((socketResponse) {
          setState(() {
            String result=String.fromCharCodes(socketResponse);
            List spilited=result.split('~');
            for(int i=0;i<spilited.length;i=i+4){
              print(spilited[i]+ spilited[i+1]+spilited[i+2]+spilited[i+3]);
              course.add(Courses(spilited[i], spilited[i+1],spilited[i+2],spilited[i+3]));
            }
          });
        });

      });

      return course;
    }

  }


class AddClassBottomSheet extends StatefulWidget {
  final Function addClassCallback;

  String username;

   AddClassBottomSheet({super.key, required this.addClassCallback, required this.username});

  @override
  State<AddClassBottomSheet> createState() => _AddClassBottomSheetState();
}

class _AddClassBottomSheetState extends State<AddClassBottomSheet> {
  TextEditingController CourseController = TextEditingController();
  TextEditingController TeacherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add New Class',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: TeacherController,
            decoration: InputDecoration(
              labelText: "Enter Teacher Name",
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.cyan),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.cyan),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: CourseController,
            decoration: InputDecoration(
              labelText: "Enter Course Name",
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.cyan),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.cyan),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              String teacher = TeacherController.text;
              String course = CourseController.text;
              setState(() {
              checker2(widget.username, teacher, course);
              widget.addClassCallback(widget.username);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text(
              'Add Class',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
  void checker2(String username, String teacher, String course, ) async {
    await Socket.connect("172.25.144.1", 7777).then((serverSocket) {
      serverSocket
          .write('ADDCLASS~$username~$teacher~$course\u0000');
      serverSocket.flush();
      serverSocket.listen((socketResponse) {

      });

    });
  }
}

class Courses {
  String name;
  String Credit;
  String NumberOfAssignment;
  String NumberOfStudents;

  Courses(this.name, this.Credit, this.NumberOfAssignment, this.NumberOfStudents);
}
