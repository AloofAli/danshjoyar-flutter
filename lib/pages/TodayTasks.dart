import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class tamrina extends StatefulWidget {
  const tamrina({super.key});

  @override
  State<tamrina> createState() => _tamrinaState();
}

class _tamrinaState extends State<tamrina> {
  final List<Assignment> _assignments = List.generate(
    6,
        (index) => Assignment("Assignment $index", "2024/12/12", "Description $index"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
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
                  'Assignments:',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _assignments.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: _assignments[index].color,
                      child: ListTile(
                        leading: IconButton(
                          icon: const Icon(Icons.task),
                          onPressed: () {
                            setState(() {
                            });
                          },
                        ),
                        title: Text(
                          _assignments[index].name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          "${_assignments[index].description}\n${_assignments[index].dateTime.split(" ").first}",
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.upload),
                          onPressed: () {
                            showModalBottomSheet(context: context,
                                builder: (context) => UploadAssignment(
                              uploadCallback: _assignments[index].changeColor));
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class UploadAssignment extends StatefulWidget {
  late Function uploadCallback;

   UploadAssignment({super.key, required this.uploadCallback});

  @override
  State<UploadAssignment> createState() => _UploadAssignmentState();
}

class _UploadAssignmentState extends State<UploadAssignment> {
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
            'Upload assignment',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
          const SizedBox(height: 10),

          GestureDetector(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                //TODO
              } else {
                //TODO
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                decoration: InputDecoration(

                  labelText: "Pick your file",
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
              setState(() {
              widget.uploadCallback();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),

            child: const Text(
              'Upload',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 24,)
        ],
      ),
    );
  }
}

class Assignment {
  String name;
  String dateTime;
  String description;
  Color color = Colors.redAccent.shade100;
  File? file;
  Assignment(this.name, this.dateTime, this.description);

  void changeColor() {

    color = (color == Colors.redAccent.shade100) ? Colors.green.shade200 : Colors.redAccent.shade100;
  }
}
