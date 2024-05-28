import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();

    bool _passwordVisible = false;
    bool _isValid = false;
    String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.linearToSrgbGamma(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: TextStyle(
                      fontSize: 20
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(
                    fontSize: 20
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _confirmNewPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle: TextStyle(
                      fontSize: 20
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isValid = validatePassword(_newPasswordController.text);

                  });
                  if (_newPasswordController.text == _confirmNewPasswordController.text) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password changed successfully!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('New password and confirm password do not match!'),
                      ),
                    );
                  }
                },
                child: Text('Change Password',style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ),
      ),
    );

  }
  bool validatePassword(String password) {
    // Reset error message
    errorMessage = '';

    // Password length greater than 6
    if (password.length < 8) {
      errorMessage += 'Password must be longer than 8 characters.\n';
    }
    // Contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      errorMessage += '• Uppercase letter is missing.\n';
    }

    // Contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      errorMessage += '• Lowercase letter is missing.\n';
    }

    // Contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      errorMessage += '• Digit is missing.\n';
    }

    // Contains at least one special character
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      errorMessage += '• Special character is missing.\n';
    }
    error();
    // If there are no error messages, the password is valid
    return errorMessage.isEmpty;
  }

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
}



