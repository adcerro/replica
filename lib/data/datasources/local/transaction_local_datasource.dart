import 'package:hive_ce/hive.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/data/datasources/local/i_transaction_local_datasource.dart';
import 'package:tester/domain/entities/transaction.dart';

class TransactionLocalDatasource implements ITransactionLocalDatasource {
  final _box = Hive.box<Transaction>('transactions');
  @override
  Future<void> addTransaction({required Transaction transaction}) async {
    await _box.add(transaction);
  }

  @override
  Future<void> deleteTransaction({required Transaction transaction}) async {
    bool foundKey = false;
    int index = 0;
    while (!foundKey && index < _box.length) {
      if (transaction == _box.get(index)) {
        foundKey = true;
      } else {
        index++;
      }
    }

    if (!foundKey) {
      throw Exception('Transaction not found');
    } else {
      await _box.delete(index);
    }
  }

  @override
  Future<List<Transaction>?> getUserTransactions({
    required String userEmail,
  }) async {
    Iterable<Transaction> userTransactions = _box.values.where(
      (element) => element.userEmail == userEmail,
    );
    if (userTransactions.isEmpty) logWarning('User has not transactions');

    return userTransactions.toList();
  }

  @override
  Future<void> updateTransaction({required Transaction transaction}) async {
    bool foundKey = false;
    int index = 0;
    while (!foundKey && index < _box.length) {
      if (transaction == _box.get(index)) {
        foundKey = true;
      } else {
        index++;
      }
    }
    if (!foundKey) {
      throw Exception('Transaction ID not found');
    }
    await _box.put(index, transaction);
  }

  @override
  Future<void> deleteAllUserTransactions({required String userEmail}) async {
    Iterable<dynamic> transactions = _box.keys.where(
      (element) => _box.get(element)!.userEmail == userEmail,
    );
    transactions.forEach(_box.delete);
  }
}
