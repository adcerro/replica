import 'package:flutter/material.dart';

class User {
  late String? name;
  final String email;
  late String password;
  late double income;
  late double budget;
  Map<String, Map<String, dynamic>> categories = {
    '': {'color': Colors.grey, 'icon': '❔'},
  };
  User({
    this.name,
    required this.email,
    required this.password,
    required this.income,
    required this.budget,
  });
}
