import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DaneshjoYar',
      home: LoginPage(),
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text(
      //     'Login',
      //     softWrap: true,
      //     style: TextStyle(
      //       fontStyle: FontStyle.italic,
      //       fontSize: 30,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg"),
                fit: BoxFit.cover,)),
          padding: const EdgeInsets.all(25.0),
        child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
           Image.asset("lib/asset/images/Sbu-logo.svg.png",
            scale: MediaQuery.of(context).size.width/55
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
          const SizedBox(height: 44),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: passwordController,
            obscureText: !_passwordVisible,
            //This will obscure text dynamically
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
              hintText: 'Enter your password',
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
              icon: Icon(Icons.key),
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
          // const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(shape: const StadiumBorder(),
            backgroundColor:Colors.black12),
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor:Colors.black12,
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
    ),);
  }
}
