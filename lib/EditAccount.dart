import 'package:danshjoyar/passwordpage.dart';
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
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _fatherController = TextEditingController();
  TextEditingController _nationalIDController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final String username;
  final String password;
  BeheshtiUniversityField? _selectedField;

  _EditAccountState(this.username, this.password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Account'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: '$username',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabled: false,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Student ID',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabled: false,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _birthdayController,
                decoration: InputDecoration(
                  labelText: 'Birthday (YYYY-MM-DD)',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _fatherController,
                decoration: InputDecoration(
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
              SizedBox(height: 20),
              TextFormField(
                controller: _nationalIDController,
                decoration: InputDecoration(
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
              SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
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
              SizedBox(height: 20),
              DropdownButtonFormField<BeheshtiUniversityField>(
                decoration: InputDecoration(
                  labelText: 'Field of Study',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                iconSize: 36,
                value: _selectedField,
                onChanged: (BeheshtiUniversityField? newValue) {
                  setState(() {
                    _selectedField = newValue;
                  });
                  // Handle selection logic here
                  print('Selected: ${newValue.toString().split('.').last}');
                },
                items: BeheshtiUniversityField.values.map((BeheshtiUniversityField field) {
                  return DropdownMenuItem<BeheshtiUniversityField>(
                    value: field,
                    child: Text(
                      field.toString().split('.').last.replaceAll('_', ' '),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                },
                child: Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordPage())),
                child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


