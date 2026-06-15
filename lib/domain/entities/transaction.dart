class Transaction implements Comparable<Transaction> {
  final double _id;
  final String _userEmail;
  late double _value;
  String? _category;
  Transaction({
    required this._id,
    required this._userEmail,
    required this._value,
    this._category,
  });

  double getId() => _id;

  String getUserEmail() => _userEmail;

  double getValue() => _value;

  String? getCategory() => _category;

  void setValue({required double newValue}) => _value = newValue;

  void setCategory({required String newCategory}) => _category = newCategory;

  @override
  int compareTo(Transaction other) {
    if (other.getId() > _id) return -1;
    if (other.getId() < _id) return 1;
    return 0;
  }
}
