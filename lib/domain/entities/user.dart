import 'package:tester/domain/entities/money_movement.dart';

class User {
  late String name;
  late String email;
  late String? password;
  late double budget;
  late double income;
  late List<MoneyMovement> movements = [];
  User({required this.name});
}
