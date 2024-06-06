import 'package:danshjoyar/pages/passwordpage.dart';
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
    DateTime selectedDate =DateTime.now();
    // Todo: change all number with These two
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Edit Account', style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),),
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: '$username',
                  labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
                  prefixStyle: const TextStyle(fontSize: 18, color: Colors.white),

                  enabled: false,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  prefixStyle: TextStyle(fontSize: 18, color: Colors.white),

                  enabled: false,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
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
                _birthdayController.text = "${pickedDate.toLocal()}".split(' ')[0];
              });
            }
          },
          child: AbsorbPointer(
            child: TextFormField(
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
              const SizedBox(height: 10),
              TextFormField(
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
              const SizedBox(height: 10),
              TextFormField(
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
              const SizedBox(height: 10),
              TextFormField(
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
              const SizedBox(height: 10),
              DropdownButtonFormField<BeheshtiUniversityField>(
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
                  // Handle selection logic here
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle Save Changes button press
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue, backgroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(vertical: 15), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Button border radius
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
                  // Navigate to ChangePasswordPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Button border radius
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
}



