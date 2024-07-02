import 'package:danshjoyar/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  bool userCanLogin = false ;

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
                  backgroundColor: Colors.black12),
              onPressed: ()async {
                String username = usernameController.text;
                String password = passwordController.text;
                await loginChecker(username, password);
                if (userCanLogin) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          profileScreen(
                              username: username, password: password)));
                }
                else if (!userCanLogin)
                  {
                    print(".............................................................................................................");
                  }
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
  
  Future<String> loginChecker(String username, String password) async {
    String userData = username + "-|-" + password ;
    String userExist = '' ;
    var socket = await Socket.connect("192.168.20.2", 7777);
    socket.write(userData);
    socket.flush();
    await socket.listen((response) {
      userExist += response.toString() ;
    });
    print(userExist);
    if (userExist == "true") {
      setState(() {
      userCanLogin = true ;

      });
    }
    return userExist ;
}
}


