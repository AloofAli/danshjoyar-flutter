import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ChangePasswordPage extends StatefulWidget {
  final String username ;
  ChangePasswordPage({required this.username});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState(username);
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();
  bool _isValid = false;
  late bool currentPasswordIsCorrect ;
  String errorMessage = '';
  final String username ;
  _ChangePasswordPageState(this.username);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Change Password',style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        )),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),

          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmNewPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,

                ),
                onPressed: () async {
                  setState(() {
                    _isValid = validatePassword(_newPasswordController.text);
                  });
                  
                  currentPasswordChecker(_currentPasswordController.text);
                  if (!currentPasswordIsCorrect)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Current password is incorrect'),
                        ),
                      );
                    }
                  if (_newPasswordController.text ==
                      _confirmNewPasswordController.text) {
                    changePassword(_newPasswordController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password changed successfully!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'New password and confirm password do not match!'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------

  bool validatePassword(String password) {
    errorMessage = '';

    if (password.length < 8) {
      errorMessage += 'Password must be longer than 8 characters.\n';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      errorMessage += '• Uppercase letter is missing.\n';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      errorMessage += '• Lowercase letter is missing.\n';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      errorMessage += '• Digit is missing.\n';
    }
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      errorMessage += '• Special character is missing.\n';
    }
    if (errorMessage.isNotEmpty) {
      error();
    }
    return errorMessage.isEmpty;
  }

  // ---------------------------------------------------------------------------

  void error() {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text("Invalid Password"),
      description: Text(errorMessage),
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(Icons.error),
      primaryColor: Colors.red,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(15),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
    ToastificationStyle;
  }

  // ---------------------------------------------------------------------------

  Future<String> currentPasswordChecker(String password) async {
    print(username);
    String currentPassword = username + "~" + password;
    String isCurrentPasswordCorrect = '';
    await Socket.connect("192.168.245.1", 7777).then((serverSocket) {
      serverSocket
          .write('CURRENTPASSWORD~$currentPassword\u0000');
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        print(socketResponse);
        setState(() {
          print(socketResponse);
          isCurrentPasswordCorrect = String.fromCharCodes(socketResponse);
          print(isCurrentPasswordCorrect);
          if (isCurrentPasswordCorrect == "true") {
            setState(() {
              currentPasswordIsCorrect = true;
            });
          } else if (isCurrentPasswordCorrect != "true") {
              setState(() {
                currentPasswordIsCorrect = false;
              });
            }
        });
      });
    });
    return isCurrentPasswordCorrect;
  }

  // ---------------------------------------------------------------------------

  void changePassword(String password) async {
    print(username);
    String newPassword = username + "~" + password;
    await Socket.connect("192.168.245.1", 7777).then((serverSocket) {
      serverSocket.write('CHANGEPASSWORD~$newPassword\u0000');
      serverSocket.flush();
    });
  }
}
