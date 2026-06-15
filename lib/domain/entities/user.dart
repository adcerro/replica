import 'package:flutter/material.dart';
import 'package:tester/domain/entities/transaction.dart';

class User {
  late String? _name;
  final String _email;
  late String _password;
  late double _budget;
  late double _income;
  late List<Transaction> _movements = [];
  User({this._name, required this._email});
  String? getName() => _name;
  String getPassword() => _password;
  String getEmail() => _email;
  double getBudget() => _budget;
  double getIncome() => _income;
  List<Transaction> getMovements() => _movements;
  void setName({required String newName}) => _name = newName;
  void setPassword({required String newPass}) => _password = newPass;
  void setBudget({required double newBudget}) => _budget = newBudget;
  void setIncome({required double newIncome}) => _income = newIncome;

  void addMovement({required Transaction movement}) {
    if (_movements.contains(movement)) {
      throw ErrorDescription('Movement with that ID already exists');
    }
    _movements.add(movement);
  }

  void removeMovement({required Transaction movement}) {
    if (!_movements.contains(movement)) {
      throw ErrorDescription('No Movement with that ID already exists');
    }
    _movements.remove(movement);
  }
}
