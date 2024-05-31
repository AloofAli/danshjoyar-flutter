import 'dart:io';
import 'dart:ui';
import 'package:danshjoyar/login.dart';
import 'package:danshjoyar/EditAccount.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class profileScreen extends StatefulWidget {
  final String username;

  final String password;

  const profileScreen(
      {super.key, required this.username, required this.password});

  @override
  State<profileScreen> createState() => _profileScreenState(username, password);
}

class _profileScreenState extends State<profileScreen> {
  final String username;

  final String password;

  _profileScreenState(this.username, this.password);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    File? _image;

    return Stack(
      children: <Widget>[
        Scaffold(
          appBar:AppBar(
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: height,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.linearToSrgbGamma())),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: height / 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: _image != null ? FileImage(_image!) : null,
                                radius: height / 10,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black54,
                                    radius: 20,
                                    child: IconButton(
                                      icon:Icon(Icons.camera_alt),
                                      color: Colors.white, onPressed: () async {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                                      if (result != null) {
                                        File file = File(result.files.single.path!);
                                        setState(() {
                                          _image=file;
                                        });
                                      } else {
                                        // User canceled the picker
                                      }
                                    },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          Text(
                            "$username",
                            style: const TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height / 3),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 3, left: width / 20, right: width / 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0)),
                                margin: const EdgeInsets.all(16.0),
                                child: Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: [
                                    _buildTableRow("StudentID", "0441281850"),
                                    _buildTableRow("Total Avrage", "18.5"),
                                    _buildTableRow("Current Term", "2"),
                                    _buildTableRow("Current term Credit", "18"),
                                    _buildTableRow("Total passed Credit", "31"),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0)),
                                margin: const EdgeInsets.all(16.0),
                                child: Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Text(
                                                "Edit acoount",
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: IconButton(
                                                splashColor: Colors.white,
                                                tooltip: "Edit account",
                                                icon: Icon(
                                                  // Based on passwordVisible state choose the icon
                                                  Icons.edit,
                                                  color: CupertinoColors.systemTeal,
                                                ),
                                                onPressed: () {
                                                  setState(() {});
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditAccount(
                                                                  username:
                                                                      username,
                                                                  password:
                                                                      password)));
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height / 20,
                          ),
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.black45,
                            ),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text(
                                    '"Warning: This button permanently deletes your account and all associated data. Proceed with caution, as this action cannot be undone."'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('No'
                                        ''),
                                  ),
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUpPage())),
                                  ),
                                ],
                              ),
                            ),
                            child: const Text('delete account',
                                style: TextStyle(
                                  letterSpacing: 3.5,
                                  color: Colors.cyan,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

TableRow _buildTableRow(String label, String value) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 15),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            value,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ),
      ),
    ],
  );
}
