import 'package:danshjoyar/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            labelColor: Colors.cyan,
            indicatorColor: Colors.cyanAccent,
            tabs: [Tab(icon: Icon(Icons.login)), Tab(icon: Icon(Icons.add))],
          ),
          body: TabBarView(
            children: [
              LoginPage(),
              SignUpPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              "lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg"),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        )),
        padding:  EdgeInsets.fromLTRB(height/25, height/25, height/25, 0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "lib/asset/images/Sbu-logo.svg.png",
              scale: MediaQuery.of(context).size.width / 60,
              filterQuality: FilterQuality.high,
            ),

            TextField(
              controller: usernameController,
              cursorColor: Colors.cyan,
                style: TextStyle(fontSize:20 ,color: Colors.white70),
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your username',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: Icon(Icons.account_circle_sharp,
                size: 35,),
                iconColor: Colors.white,
              ),
            ),
            // const SizedBox(height: 44),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: !_passwordVisible,
              style: TextStyle(fontSize:20 ,color: Colors.white70),

              //This will obscure text dynamically
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle:
                    const TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your password',
                hintStyle:
                    const TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: const Icon(Icons.key,
                size: 35,),
                iconColor: Colors.white,
                // Here is key idea
                suffixIcon: IconButton(
                  splashColor: Colors.white,
                  tooltip: "Change visibility",
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).dialogBackgroundColor,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
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
                  backgroundColor: Colors.black12),
              onPressed: () {
                String username = usernameController.text;
                String password = passwordController.text;
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  profileScreen(username: username,password: password,)));
              },
              child: const Text('Login',
                  style: TextStyle(
                    letterSpacing: 3.5,
                    color: Colors.cyan,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _passwordVisible = false;
  bool _isValid = false;
  String _errorMessage = '';
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
        padding:  EdgeInsets.fromLTRB(height/25, height/25, height/25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("lib/asset/images/Sbu-logo.svg.png",
                scale: width / 60),
            TextFormField(
              style: TextStyle(fontSize:20 ,color: Colors.white70),
              keyboardType: TextInputType.text,
              controller: usernameController,
              cursorColor: Colors.white,
              cursorOpacityAnimates: true,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your username',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: Icon(Icons.account_circle_sharp,
                size: 35,),
                iconColor: Colors.white,
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize:20 ,color: Colors.white70),

              keyboardType: TextInputType.text,
              controller: studentIDController,
              cursorColor: Colors.white,
              cursorOpacityAnimates: true,
              decoration: const InputDecoration(
                labelText: 'StudentID',
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your StudentID',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: Icon(Icons.account_circle_outlined,
                size: 35,),
                iconColor: Colors.white,
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize:20 ,color: Colors.white70),

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
                icon: Icon(Icons.key,size: 35,),
                iconColor: Colors.white,
                // Here is key idea
                suffixIcon: IconButton(
                  splashColor: Colors.white,
                  tooltip: "Change visibility",
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
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
              onPressed: () {
                setState(() {
                  _isValid = _validatePassword(passwordController.text);
                });
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

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    studentIDController.dispose();
    super.dispose();
  }

  // Function to validate the password
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
    error();
    // If there are no error messages, the password is valid
    return _errorMessage.isEmpty;
  }

  void error() {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text("Invalid Password"),
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
}
