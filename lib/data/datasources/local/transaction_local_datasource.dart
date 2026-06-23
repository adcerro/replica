import 'package:hive_ce/hive.dart';
import 'package:tester/data/datasources/local/i_transaction_local_datasource.dart';
import 'package:tester/domain/entities/transaction.dart';

class TransactionLocalDatasource implements ITransactionLocalDatasource {
  final _box = Hive.box<Transaction>('transactions');
  @override
  Future<void> addTransaction({required Transaction transaction}) async {
    if (_box.values.contains(transaction)) {
      throw Exception('Transaction ID in use');
    } else {
      _box.put('${transaction.userEmail}-${transaction.dateTime}', transaction);
    }
  }

  @override
  Future<void> deleteTransaction({required Transaction transaction}) async {
    if (!_box.values.contains(transaction)) {
      throw Exception('Transaction not found');
    } else {
      _box.delete('${transaction.userEmail}-${transaction.dateTime}');
    }
  }

  @override
  Future<List<Transaction>> getUserTransactions({
    required String userEmail,
  }) async {
    Iterable<dynamic> transactionKeys = _box.keys.where(
      (element) => (element as String).startsWith(userEmail),
    );
    if (transactionKeys.isEmpty) {
      throw Exception('User has not transactions');
    }
    List<Transaction> transactions = [];
    for (var key in transactionKeys) {
      transactions.add(_box.get(key)!);
    }
    return transactions;
  }

  @override
  Future<void> updateTransaction({required Transaction transaction}) async {
    String transactionKey = '${transaction.userEmail}-${transaction.dateTime}';
    if (!_box.keys.contains(transactionKey)) {
      throw Exception('Transaction ID not found');
    }
    _box.put(transactionKey, transaction);
  }

  @override
  Future<void> deleteAllUserTransactions({required String userEmail}) async {
    Iterable<dynamic> transactions = _box.keys.where(
      (element) => (element as String).startsWith(userEmail),
    );
    transactions.forEach(_box.delete);
  }
}
