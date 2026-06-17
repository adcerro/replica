import 'package:hive_ce/hive.dart';
import 'package:tester/data/datasources/local/i_transaction_local_datasource.dart';
import 'package:tester/domain/entities/transaction.dart';

class TransactionLocalDatasource implements ITransactionLocalDatasource {
  final _box = Hive.box<List>('transactions');
  @override
  Future<void> addTransaction({required Transaction transaction}) async {
    if (!_box.keys.contains(transaction.getUserEmail())) {
      throw Exception('User not found');
    }
    List<Transaction>? transactions = List<Transaction>.from(
      _box.get(transaction.getUserEmail()) ?? [],
    );
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
    if (!_box.keys.contains(userEmail)) {
      throw Exception('User not found');
    }
    List<Transaction>? transactions = List<Transaction>.from(
      _box.get(userEmail) ?? [],
    );
    if (transactions.isEmpty) {
      throw Exception('Transactions not found');
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
    if (!_box.keys.contains(userEmail)) {
      throw Exception('User not found');
    }
    return List<Transaction>.from(_box.get(userEmail) ?? []);
  }

  @override
  Future<void> updateTransaction({required Transaction transaction}) async {
    if (!_box.keys.contains(transaction.getUserEmail())) {
      throw Exception('User not found');
    }
    List<Transaction>? transactions = List<Transaction>.from(
      _box.get(transaction.getUserEmail()) ?? [],
    );
    if (transactions.isEmpty) {
      throw Exception('Transactions not found');
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
