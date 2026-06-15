class MoneyMovement {
  final double _id;
  late double _value;
  String? _category;
  MoneyMovement({required this._id, required this._value, this._category});

  double getId() {
    return _id;
  }

  double getValue() {
    return _value;
  }

  void setValue({required double newValue}) {
    _value = newValue;
  }

  String? getCategory() {
    return _category;
  }

  void setCategory({required String newCategory}) {
    _category = newCategory;
  }
}
