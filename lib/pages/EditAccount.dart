import 'dart:io';

import 'package:danshjoyar/pages/ChangePasswordPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:danshjoyar/Main/BeheshtiUniversityField.dart';

class EditAccount extends StatefulWidget {
  final String username;
  final String password;
  EditAccount({required this.username, required this.password});

  @override
  _EditAccountState createState() => _EditAccountState(username, password);
}

class _EditAccountState extends State<EditAccount> {

  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _fatherController = TextEditingController();
  final TextEditingController _nationalIDController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final String username;
  final String password;
  BeheshtiUniversityField? _selectedField;
  _EditAccountState(this.username, this.password);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Edit Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children: [
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
                      _birthdayController.text = "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                    controller: _birthdayController,
                    decoration: const InputDecoration(
                      labelText: 'Birthday',
                      labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                style: TextStyle(fontSize: 20, color: Colors.white70),
                controller: _fatherController,
                decoration: const InputDecoration(
                  labelText: 'Father Name',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                style: TextStyle(fontSize: 20, color: Colors.white70),
                controller: _nationalIDController,
                decoration: const InputDecoration(
                  labelText: 'National ID',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                style: TextStyle(fontSize: 20, color: Colors.white70),
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<BeheshtiUniversityField>(
                style: TextStyle(fontSize: 20, color: Colors.white70),
                decoration: const InputDecoration(
                  labelText: 'Field of Study',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                iconSize: 36,
                value: _selectedField,
                onChanged: (BeheshtiUniversityField? newValue) {
                  setState(() {
                    _selectedField = newValue;
                  });
                  print('Selected: ${newValue.toString().split('.').last}');
                },
                items: BeheshtiUniversityField.values.map((BeheshtiUniversityField field) {
                  return DropdownMenuItem<BeheshtiUniversityField>(
                    value: field,
                    child: Text(
                      field.toString().split('.').last.replaceAll('_', ' '),
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  editAccount();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePasswordPage(username: username)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------

  void editAccount() async {
    String userData = username + "~" + _birthdayController.text + "~" + _fatherController.text + "~" + _nationalIDController.text + "~" + _phoneController.text + "~" + _selectedField.toString();
    await Socket.connect("172.28.0.1", 7777).then((serverSocket) {
      serverSocket.write('EDITACCOUNT~$userData\u0000');
      serverSocket.flush();
      serverSocket.listen((response) {
        String serverResponse = String.fromCharCodes(response);
        if (serverResponse.contains("success")) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account details updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update account details.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    });
  }
}
