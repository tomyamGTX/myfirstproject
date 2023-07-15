import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();

  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: email,
            decoration: const InputDecoration(hintText: "Please insert email"),
          ),
          TextFormField(
            obscureText: true,
            controller: password,
            decoration:
                const InputDecoration(hintText: "Please insert password"),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                ElevatedButton(onPressed: _login, child: const Text("LOGIN")),
          )
        ],
      ),
    ));
  }

  void _login() {
    if (email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all details")));
    } else {
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }
}
