import 'package:flutter/material.dart';
import 'db_helper.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      final user = await DBHelper.signInUser(
        usernameController.text,
        passwordController.text,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Successful! Welcome ${user['firstName']}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Username or Password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: usernameController, decoration: InputDecoration(labelText: 'Username'), validator: (value) => value!.isEmpty ? 'Enter username' : null),
              TextFormField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true, validator: (value) => value!.isEmpty ? 'Enter password' : null),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _signIn, child: Text('Sign In')),
            ],
          ),
        ),
      ),
    );
  }
}
