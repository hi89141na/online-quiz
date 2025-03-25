import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'signin_screen.dart';

void main() {
  runApp(MaterialApp(
    home: SignInScreen(),
    routes: {
      '/signup': (context) => SignUpScreen(),
    },
  ));
}

