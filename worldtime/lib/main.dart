import 'package:flutter/material.dart';
import 'package:worldtime/pages/home.dart';
import 'package:worldtime/pages/location.dart';
import 'package:worldtime/pages/loading.dart';
void main()=> runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => LoadingScreen(),
    '/home': (context) => Home(),
    '/location': (context) => Location(),
  },
));


