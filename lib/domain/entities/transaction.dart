class Transaction implements Comparable<Transaction> {
  final DateTime dateTime = DateTime.now();
  final String userEmail;
  late double value;
  String? category;
  Transaction({required this.userEmail, required this.value, this.category});

  @override
  int compareTo(Transaction other) {
    if (other.userEmail.compareTo(userEmail) > 0) return -1;
    if (other.userEmail.compareTo(userEmail) < 0) return 1;

    if (other.dateTime.isAfter(dateTime)) return -1;
    if (other.dateTime.isBefore(dateTime)) return 1;

    return 0;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    Transaction otherTrans = other as Transaction;
    try {
      otherTrans.userEmail;
      otherTrans.dateTime;
    } catch (e) {
      return false;
    }
    if (otherTrans.userEmail == userEmail && otherTrans.dateTime == dateTime) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode => dateTime.hashCode ^ userEmail.hashCode;
}
