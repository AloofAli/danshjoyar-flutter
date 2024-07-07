import 'dart:io';

import 'package:flutter/material.dart';

class kara extends StatefulWidget {
  String username;

  kara(this.username, {super.key});

  @override
  State<kara> createState() => _karaState(username);
}

class _karaState extends State<kara> {
  List<Task> allTasks = [];
  List<Task> doneTasks = [];

  String username;

  _karaState(this.username);

  @override
  void initState() {
    super.initState();
    _loadTasks(username);
  }

  Future<void> _loadTasks(String username) async {
    List<Task> tasks = await fetchTasks(username);
    setState(() {
      allTasks = tasks;
      print("tasks =$tasks");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    allTasks.remove(index);
                                    removetask(username, allTasks[index].name);
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
                            trailing: IconButton(
                              icon:
                              const Icon(Icons.arrow_forward_ios_outlined),
                              onPressed: () {
                                setState(() {
                                  //TODO
                                });
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
                            title: Text(doneTasks[index].name,
                                style: TextStyle(fontSize: 18)),
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
            builder: (context) => TaskBottomSheet(username,_loadTasks),
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
    await Socket.connect("172.25.144.1", 7777).then((serverSocket) {
      serverSocket.write('SHOWTASKS~$username\u0000');
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        String result = String.fromCharCodes(socketResponse);
        List<String> spilitedBYline = result.split("\n");
        for (int i = 0; i < spilitedBYline.length; i++) {
          List<String> line = spilitedBYline.elementAt(i).split("~");
          tasks.add(Task(line.first, line.elementAt(1), line.elementAt(2)));
        }
      });
    });
    return tasks;
  }

  Future<void> removetask(String username, String name) async {
    await Socket.connect("172.25.144.1", 7777).then((serverSocket) {
      serverSocket.write('DELETETASK~$username~$name\u0000');
    });
    setState(() {

      _loadTasks(username);
    });
  }

}

class TaskBottomSheet extends StatefulWidget {
  String username;

  Function function;

  TaskBottomSheet(this.username, this.function,{super.key});

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
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
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
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
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
                  _dateController.text =
                  "${pickedDate.toLocal()}".split(' ')[0];
                });
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Pick your Deadline date",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
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
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
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
              addtask(widget.username, task ,widget.function);
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
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }

  Future<void> addtask(String username, Task task, Function function) async {
    await Socket.connect("172.25.144.1", 7777).then((serverSocket) {
      serverSocket.write(
          'ADDTASK~${username}~${task.name}~${task.dateTime}~${task.description}\u0000');
      serverSocket.flush();
      serverSocket.listen((socketResponse) {});
    });
    setState(() {

      function(username);
    });
  }

}

class Task {
  String name="";
  String dateTime="";
  String description="";

  Task(this.name, this.dateTime, this.description);
}