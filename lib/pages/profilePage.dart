import 'dart:io';
import 'dart:ui';
import 'package:danshjoyar/pages/EditAccount.dart';
import 'package:danshjoyar/pages/Signup%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class profileScreen extends StatefulWidget {
  final String username;
  final String password;

  const profileScreen({super.key, required this.username, required this.password});

  @override
  State<profileScreen> createState() => _profileScreenState(username, password);
}

File? _image;

class _profileScreenState extends State<profileScreen> {
  final String username;
  final String password;
  String studentID = '';
  String totalAverage = '';
  String currentTerm = '';
  String currentTermCredit = '';
  String totalPassedCredit = '';

  _profileScreenState(this.username, this.password);

  @override
  void initState() {
    super.initState();
    initDatas();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: height,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: height / 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: _load,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: _image == null
                                    ? Icon(Icons.camera_alt, size: 70, color: Colors.grey)
                                    : Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 140,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height / 100),
                          Text(
                            username,
                            style: const TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height / 3),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height / 3, left: width / 20, right: width / 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: height / 50),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                margin: const EdgeInsets.all(16.0),
                                child: Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: [
                                    _buildTableRow("StudentID", studentID),
                                    _buildTableRow("Total Average", totalAverage),
                                    _buildTableRow("Current Term", currentTerm),
                                    _buildTableRow("Current Term Credit", currentTermCredit),
                                    _buildTableRow("Total Passed Credit", totalPassedCredit),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                margin: const EdgeInsets.all(16.0),
                                child: Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              "Edit account",
                                              style: const TextStyle(color: Colors.grey, fontSize: 20),
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
                                                Icons.edit,
                                                color: CupertinoColors.systemTeal,
                                              ),
                                              onPressed: () {
                                                setState(() {});
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => EditAccount(username: username, password: password),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height / 30),
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.black45,
                            ),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text('"Warning: This button permanently deletes your account and all associated data. Proceed with caution, as this action cannot be undone."'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                  ),
                                  TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () async {
                                        await deleteAccount();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (
                                                context) => const SignUpPage(),
                                          ),
                                        );
                                      }
                                  ),
                                ],
                              ),
                            ),
                            child: const Text(
                              'Delete account',
                              style: TextStyle(
                                letterSpacing: 3.5,
                                color: Colors.cyan,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _loadimage(File file) {
    setState(() {
      _image = file;
    });
  }

  Future<void> _load() async {
    var picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<String> deleteAccount() async {
    String un = username;
    await Socket.connect("172.28.0.1", 7777).then((serverSocket) {
      serverSocket.write('DELETEACCOUNT~$un\u0000');
      serverSocket.flush();
    });
    return ""; //this method doesn't need return type , the return type is just for handling compile error
  }

  void initDatas() async {
    String userData = username;
    await Socket.connect("172.28.0.1", 7777).then((serverSocket) {
      serverSocket.write('PROFILE~$userData\u0000');
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        setState(() {
          var splited = String.fromCharCodes(socketResponse).split("-");
          studentID = splited.elementAt(0);
          totalAverage = splited.elementAt(1);
          currentTerm = splited.elementAt(2);
          currentTermCredit = splited.elementAt(3);
          totalPassedCredit = splited.elementAt(4);
          print(studentID);
          print(totalAverage);
          print(currentTerm);
          print(currentTermCredit);
          print(totalPassedCredit);
        });
      });

    });
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
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 15),
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