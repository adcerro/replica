import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/domain/entities/transaction.dart';
import 'package:tester/domain/repositories/i_transaction_repository.dart';

class TransactionController extends GetxController {
  final ITransactionRepository _transactionUseCase;
  List<Transaction> currentUserTransactions = [];

  TransactionController({required this._transactionUseCase});

  Future<List<Transaction>?> getUserTransactions({
    required String userEmail,
  }) async {
    List<Transaction>? userTransactions = await _transactionUseCase
        .getUserTransactions(userEmail: userEmail);
    logInfo('Got ${userTransactions?.length} transactions for the user');
    currentUserTransactions = userTransactions ?? [];
    return userTransactions;
  }

  double getMonthTotal({int month = 1}) {
    return currentUserTransactions
        .where((transation) => transation.dateTime.month == month)
        .fold(0, (total, transaction) => total += transaction.value);
  }

  List<MapEntry<DateTime, List<Transaction>>> groupTransactionsByDate() {
    Map<DateTime, List<Transaction>> grouped = {};

    for (Transaction trans in currentUserTransactions!) {
      DateTime key = DateTime(
        trans.dateTime.year,
        trans.dateTime.month,
        trans.dateTime.day,
      );
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(trans);
    }

    return grouped.entries.toList();
  }

  Future<void> addTransaction({required Transaction transaction}) async {
    await _transactionUseCase.addTransaction(transaction: transaction);
    logInfo(
      'Added transaction for ${transaction.userEmail}, with date: ${transaction.dateTime}',
    );
  }

  Future<bool> updateTransaction({required Transaction transaction}) async {
    try {
      await _transactionUseCase.updateTransaction(transaction: transaction);
      logInfo('Updated transaction with for ${transaction.userEmail}');
      return true;
    } catch (e) {
      logError('Error updating the transaction. ${e.toString()}');
      return false;
    }
  }

  Future<bool> deleteTransaction({required Transaction transaction}) async {
    try {
      await _transactionUseCase.deleteTransaction(transaction: transaction);
      logInfo(
        'Deleted transaction with for ${transaction.userEmail}, with date: ${transaction.dateTime}',
      );
      return true;
    } catch (e) {
      logError('Error deleting the transaction. ${e.toString()}');
      return false;
    }
  }

  Future<void> deleteAllUserTransactions({required String userEmail}) async {
    await _transactionUseCase.deleteAllUserTransactions(userEmail: userEmail);
    logInfo('Emptied transaction list for $userEmail');
  }
}
