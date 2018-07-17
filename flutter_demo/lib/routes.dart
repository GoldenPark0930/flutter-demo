import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/home/home_screen.dart';
import 'package:flutter_demo/screens/login/login_screen.dart';

// array Defined no of Views app will Travel
final routes = {
    '/login': (BuildContext context) => new LoginScreen(),
    '/home': (BuildContext context) => new HomeScreen(),
    '/': (BuildContext context) => new LoginScreen()
};  