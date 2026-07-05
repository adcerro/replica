import 'category_info.dart';

class User {
  late String? name;
  final String email;
  late String password;
  late double income;
  late double budget;
  Map<String, CategoryInfo> categories = {};
  User({
    this.name,
    required this.email,
    required this.password,
    required this.income,
    required this.budget,
  });
}
