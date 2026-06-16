import 'package:hive_ce/hive.dart';
import 'package:tester/data/datasources/local/i_transaction_local_datasource.dart';
import 'package:tester/domain/entities/transaction.dart';

class TransactionLocalDatasource implements ITransactionLocalDatasource {
  final _box = Hive.box<List<Transaction>>('transactions');
  @override
  Future<void> addTransaction({required Transaction transaction}) async {
    List<Transaction>? transactions = _box.get(transaction.getUserEmail());
    if (transactions == null) {
      throw Exception('User not found');
    }
    if (transactions.isEmpty) {
      _box.put(transaction.getUserEmail(), [transaction]);
    } else {
      transactions.contains(transaction)
          ? throw Exception('Transaction ID already in use')
          : _box.put(transaction.getUserEmail(), transactions + [transaction]);
    }
  }

  @override
  Future<void> deleteTransaction({
    required String userEmail,
    required double id,
  }) async {
    List<Transaction>? transactions = _box.get(userEmail);
    if (transactions == null || transactions.isEmpty) {
      throw Exception('User/Transactions not found');
    }
    Transaction trans = Transaction(id: id, userEmail: userEmail, value: 0);
    if (!transactions.contains(trans)) {
      throw Exception('Transaction ID not found');
    }
    transactions.remove(trans);
    _box.put(userEmail, transactions);
  }

  @override
  Future<List<Transaction>?> getUserTransactions({
    required String userEmail,
  }) async {
    List<Transaction>? transactions = _box.get(userEmail);
    if (transactions == null) {
      throw Exception('User not found');
    }
    return transactions;
  }

  @override
  Future<void> updateTransaction({required Transaction transaction}) async {
    List<Transaction>? transactions = _box.get(transaction.getUserEmail());
    if (transactions == null || transactions.isEmpty) {
      throw Exception('User/Transactions not found');
    }
    if (!transactions.contains(transaction)) {
      throw Exception('Transaction ID not found');
    }
    transactions[transactions.indexOf(transaction)] = transaction;
    _box.put(transaction.getUserEmail(), transactions);
  }

  @override
  Future<void> deleteAllUserTransactions({
    required String userEmail,
    required bool accountDeletion,
  }) async {
    if (!_box.keys.contains(userEmail)) {
      throw Exception('User not found');
    }
    accountDeletion ? _box.delete(userEmail) : _box.put(userEmail, []);
  }
}
