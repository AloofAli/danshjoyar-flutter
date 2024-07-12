import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class Kara extends StatefulWidget {
  final String username;

  Kara(this.username, {Key? key}) : super(key: key);

  @override
  State<Kara> createState() => _KaraState();
}

class _KaraState extends State<Kara> {
  List<Task> allTasks = [];
  List<Task> doneTasks = [];
  late String username;

  @override
  void initState() {
    super.initState();
    username = widget.username;
    _loadTasks(username);
  }

  Future<void> _loadTasks(String username) async {
    List<Task> tasks = await fetchTasks(username);
    setState(() {
      allTasks = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/asset/images/casey-horner-4rDCa5hBlCs-unsplash.jpg"),
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
                    height: 500,
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
                                  allTasks.removeAt(index);
                                  removeTask(username, doneTasks.last.name);
                                });
                              },
                            ),
                            title: Text(
                              allTasks[index].name,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(allTasks[index].dateTime.split(" ").first),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios_outlined),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DescriptionDialog(text: allTasks[index].description),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Completed Tasks:',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: doneTasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white.withOpacity(0.5),
                          child: ListTile(
                            leading: Icon(Icons.done),
                            title: Text(doneTasks[index].name, style: TextStyle(fontSize: 18)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => TaskBottomSheet(username, _loadTasks),
          );
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        tooltip: "Add Todo",
      ),
    );
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

  Future<void> removeTask(String username, String name) async {
    try {
      final socket = await Socket.connect("192.168.245.1", 7777);
      socket.write('DELETETASK~$username~$name\u0000');
      await socket.flush();
      await socket.close();
      _loadTasks(username);
    } catch (e) {
      print("Failed to remove task: $e");
    }
  }
}

class DescriptionDialog extends StatelessWidget {
  final String text;

  DescriptionDialog({required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Task Description:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

class TaskBottomSheet extends StatefulWidget {
  final String username;
  final Function refreshTasks;

  TaskBottomSheet(this.username, this.refreshTasks, {Key? key}) : super(key: key);

  @override
  _TaskBottomSheetState createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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
          Text(
            'Add New Task',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _subjectController,
            decoration: InputDecoration(
              labelText: "Enter your Task Subject",
              labelStyle: TextStyle(fontSize: 18, color: Colors.grey[700]),
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.cyan),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.cyan),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: "Enter Task Description",
              labelStyle: TextStyle(fontSize: 18, color: Colors.grey[700]),
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.cyan),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.cyan),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                  _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                });
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Pick your Deadline date",
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  filled: true,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
              );
              if (pickedTime != null) {
                setState(() {
                  selectedTime = pickedTime;
                  _timeController.text = pickedTime.format(context);
                });
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: "Pick your Deadline time",
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  filled: true,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final task = Task(
                _subjectController.text,
                "${_dateController.text} ${_timeController.text}",
                _descriptionController.text,
              );
              addTask(widget.username, task, widget.refreshTasks);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text(
              'Add Task',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> addTask(String username, Task task, Function refreshTasks) async {
    try {
      final socket = await Socket.connect("192.168.245.1", 7777);
      socket.write('ADDTASK~$username~${task.name}~${task.dateTime}~${task.description}\u0000');
      await socket.flush();
      await socket.close();
      refreshTasks(username);
    } catch (e) {
      print("Failed to add task: $e");
    }
  }
}

class Task {
  String name;
  String dateTime;
  String description;

  Task(this.name, this.dateTime, this.description);
}
