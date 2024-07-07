import 'dart:io';

import 'package:danshjoyar/mainPageHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

//-----------------------------------------------------------------------------

class _SignUpPageState extends State<SignUpPage> {
  bool _passwordVisible = false;
  bool _isValid = false;
  String _errorMessage = '';
  bool userCanSignUp = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController studentIDController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg",
          ),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.fromLTRB(height / 25, height / 25, height / 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("lib/asset/images/Sbu-logo.svg.png", scale: width / 60),
            TextFormField(
              style: TextStyle(fontSize: 20, color: Colors.white70),
              keyboardType: TextInputType.text,
              controller: usernameController,
              cursorColor: Colors.white,
              cursorOpacityAnimates: true,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your username',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: Icon(
                  Icons.account_circle_sharp,
                  size: 35,
                ),
                iconColor: Colors.white,
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize: 20, color: Colors.white70),
              keyboardType: TextInputType.text,
              controller: studentIDController,
              cursorColor: Colors.white,
              cursorOpacityAnimates: true,
              decoration: const InputDecoration(
                labelText: 'StudentID',
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your StudentID',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: Icon(
                  Icons.account_circle_outlined,
                  size: 35,
                ),
                iconColor: Colors.white,
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize: 20, color: Colors.white70),
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: !_passwordVisible,
              cursorColor: Colors.white,
              cursorOpacityAnimates: true,
              decoration: InputDecoration(
                labelText: 'Create Password',
                labelStyle:
                    const TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your password',
                hintStyle:
                    const TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: Icon(
                  Icons.key,
                  size: 35,
                ),
                iconColor: Colors.white,
                suffixIcon: IconButton(
                  splashColor: Colors.white,
                  tooltip: "Change visibility",
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).dialogBackgroundColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.black12,
              ),
              onPressed: () async {
                setState(() {
                  _isValid = _validatePassword(passwordController.text);
                });
                String username = usernameController.text;
                String studentID = studentIDController.text;
                String password = passwordController.text;

                await signupChecker(username, studentID, password);

                if (userCanSignUp) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => mainPageHandler(
                              username: usernameController.text,
                              password: passwordController.text)));
                }

                if (!userCanSignUp) {
                  error_username_signup();
                }
              },
              child: const Text('Register',
                  style: TextStyle(
                    letterSpacing: 3.5,
                    color: Colors.cyan,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ],
        ),
      ),
    );
  }

//-----------------------------------------------------------------------------

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    studentIDController.dispose();
    super.dispose();
  }

//-----------------------------------------------------------------------------

  bool _validatePassword(String password) {
    // Reset error message
    _errorMessage = '';

    // Password length greater than 6
    if (password.length < 8) {
      _errorMessage += 'Password must be longer than 8 characters.\n';
    }
    // Contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _errorMessage += '• Uppercase letter is missing.\n';
    }

    // Contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      _errorMessage += '• Lowercase letter is missing.\n';
    }

    // Contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      _errorMessage += '• Digit is missing.\n';
    }

    // Contains at least one special character
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      _errorMessage += '• Special character is missing.\n';
    }
    if (_errorMessage.isNotEmpty) {
      error();
    }
    // If there are no error messages, the password is valid
    return _errorMessage.isEmpty;
  }

//-----------------------------------------------------------------------------

  void error() {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text("Invalid password"),
      description: Text(_errorMessage),
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

//-----------------------------------------------------------------------------

  void error_username_signup() {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text("The StudentID or Username is already signed up !!!!!"),
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

//-----------------------------------------------------------------------------

  Future<String> signupChecker(
      String username, String studentID, String password) async {
    String userData = username + "~" + studentID + "~" + password;
    String canUserSignUp = '';
    await Socket.connect("172.28.0.1", 7777).then((serverSocket) {
      serverSocket.write('SIGNUP~$userData\u0000');
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        print(socketResponse);
        setState(() {
          print(socketResponse);
          canUserSignUp = String.fromCharCodes(socketResponse);
          print(canUserSignUp);
          if (canUserSignUp == "not repetitive") {
            setState(() {
              userCanSignUp = true;
            });
          }
        });
      });
    });

    return canUserSignUp;
  }
}
