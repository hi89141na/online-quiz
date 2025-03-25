import 'package:flutter/material.dart';
import 'db_helper.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await DBHelper.signUpUser(
          firstNameController.text,
          lastNameController.text,
          emailController.text,
          usernameController.text,
          passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up Successful!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: firstNameController, decoration: InputDecoration(labelText: 'First Name'), validator: (value) => value!.isEmpty ? 'Enter first name' : null),
              TextFormField(controller: lastNameController, decoration: InputDecoration(labelText: 'Last Name'), validator: (value) => value!.isEmpty ? 'Enter last name' : null),
              TextFormField(controller: emailController, decoration: InputDecoration(labelText: 'Email'), validator: (value) => value!.isEmpty ? 'Enter email' : null),
              TextFormField(controller: usernameController, decoration: InputDecoration(labelText: 'Username'), validator: (value) => value!.isEmpty ? 'Enter username' : null),
              TextFormField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true, validator: (value) => value!.isEmpty ? 'Enter password' : null),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _signUp, child: Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
