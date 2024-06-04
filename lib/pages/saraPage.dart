import 'package:danshjoyar/pages/EditAccount.dart';
import 'package:flutter/material.dart';

class sara extends StatefulWidget {
  const sara({super.key});

  @override
  State<sara> createState() => _SaraState();
}

class _SaraState extends State<sara> {
  List<String> tasks = List<String>.generate(
      10, (index) => 'Task ${index + 1}');
  List<String> doneTasks = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
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
                    builder: (context) =>
                        EditAccount(
                          password: "",
                          username: "",
                        ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery
                  .of(context)
                  .size
                  .height,
            ),
            child: IntrinsicHeight(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg",
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black38, BlendMode.darken),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  MediaQuery
                      .of(context)
                      .size
                      .height / 25,
                  MediaQuery
                      .of(context)
                      .size
                      .height / 10,
                  MediaQuery
                      .of(context)
                      .size
                      .height / 25,
                  MediaQuery
                      .of(context)
                      .size
                      .height / 25,
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
                        _buildSummaryBox(icon: Icon(Icons.school),
                            text: " Exam:",
                        width: 110),
                        _buildSummaryBox(icon: Icon(Icons.task),
                            text: " DeadLine:",width: 100),
                        _buildSummaryBox(icon: Icon(Icons.star),
                            text: " Best Score:",
                        width: 110),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSummaryBox(icon: Icon(Icons.restore_from_trash_outlined),
                            text: " Worst Score:",),
                        _buildSummaryBox(icon: Icon(Icons.done_outlined),
                            text: "Done:",
                        ),

                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Current Tasks:',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white.withOpacity(0.8),
                            child: ListTile(
                              leading: Icon(Icons.task_outlined),
                              title: Text(tasks[index]),
                              trailing: IconButton(
                                icon: Icon(Icons.circle_outlined),
                                onPressed: () {
                                  setState(() {
                                    doneTasks.add(tasks[index]);
                                    tasks.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Completed Tasks:',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: doneTasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white.withOpacity(0.5),
                            child: ListTile(
                              leading: Icon(Icons.done),
                              title: Text(doneTasks[index]),
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
      ),
    );
  }
  Widget _buildSummaryBox({required String text, required Icon icon, double width = 120}) {
    return Container(
      width: width,
      height: 100, // Increased height to accommodate icon and text
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
          icon,
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}