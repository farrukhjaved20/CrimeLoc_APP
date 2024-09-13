import 'package:flutter/material.dart';

class MyControllers {
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController descpcontroller = TextEditingController();
  clear() {
    passwordcontroller.clear();
    namecontroller.clear();
    emailcontroller.clear();
    descpcontroller.clear();
  }
}

MyControllers myControllers = MyControllers();
