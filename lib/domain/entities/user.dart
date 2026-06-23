class User {
  late String? name;
  final String email;
  late String password;
  late double income;
  late double budget;
  User({
    this.name,
    required this.email,
    required this.password,
    required this.income,
    required this.budget,
  });
}
