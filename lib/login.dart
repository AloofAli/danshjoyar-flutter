import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner:false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            labelColor: Colors.cyan,
            indicatorColor: Colors.cyanAccent,

            tabs: [
              Tab(icon: Icon(Icons.login)),
              Tab(icon: Icon(Icons.add))
            ],
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg"),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            )),
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "lib/asset/images/Sbu-logo.svg.png",
              scale: MediaQuery
                  .of(context)
                  .size
                  .width / 60,
              filterQuality: FilterQuality.high,
            ),

            TextField(
              controller: usernameController,
              cursorColor: Colors.cyan,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your username',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: Icon(Icons.account_circle_sharp),
                iconColor: Colors.white,
              ),
            ),
            // const SizedBox(height: 44),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: !_passwordVisible,
              //This will obscure text dynamically
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your password',
                hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: const Icon(Icons.key),
                iconColor: Colors.white,
                // Here is key idea
                suffixIcon: IconButton(
                  splashColor: Colors.white,
                  tooltip: "Change visibility",
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Theme
                        .of(context)
                        .dialogBackgroundColor,
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
    )
    ;
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg",
              ),
              fit: BoxFit.fill,
            )),
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("lib/asset/images/Sbu-logo.svg.png",
                  scale: MediaQuery.of(context).size.width / 60),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: usernameController,
                cursorColor: Colors.white,
                cursorOpacityAnimates: true,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
                  icon: Icon(Icons.account_circle_sharp),
                  iconColor: Colors.white,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: studentIDController,
                cursorColor: Colors.white,
                cursorOpacityAnimates: true,
                decoration: const InputDecoration(
                  labelText: 'StudentID',
                  labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                  hintText: 'Enter your StudentID',
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
                  icon: Icon(Icons.account_circle_sharp),
                  iconColor: Colors.white,
                ),
              ),
              // SizedBox(height:0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: passwordController,
                obscureText: !_passwordVisible,
                cursorColor: Colors.white,
                cursorOpacityAnimates: true,
                decoration: InputDecoration(
                  helperText: "Create a password with at least 8 characters",
                  helperStyle: const TextStyle(color: Colors.black),
                  labelText: 'Create Password',
                  labelStyle:
                  const TextStyle(fontSize: 20.0, color: Colors.white),
                  hintText: 'Enter your password',
                  hintStyle:
                  const TextStyle(fontSize: 20.0, color: Colors.white70),
                  icon: Icon(Icons.key),
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

              // const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.black12,
                ),
                onPressed: () {},
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
}
