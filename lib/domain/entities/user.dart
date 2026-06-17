class User {
  late String? _name;
  final String _email;
  late String _password;
  late double _income;
  late double _budget;
  User({
    this._name,
    required this._email,
    required this._password,
    required this._income,
    required this._budget,
  });
  String? getName() => _name;
  String getPassword() => _password;
  String getEmail() => _email;
  double getBudget() => _budget;
  double getIncome() => _income;
  void setName({required String newName}) => _name = newName;
  void setPassword({required String newPass}) => _password = newPass;
  void setBudget({required double newBudget}) => _budget = newBudget;
  void setIncome({required double newIncome}) => _income = newIncome;
}
