import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/domain/entities/transaction.dart';
import 'package:tester/domain/repositories/i_transaction_repository.dart';

class TransactionController extends GetxController {
  final ITransactionRepository _transactionUseCase;

  TransactionController({required this._transactionUseCase});

  Future<List<Transaction>?> getUserTransactions({
    required String userEmail,
  }) async {
    try {
      List<Transaction>? userTransactions = await _transactionUseCase
          .getUserTransactions(userEmail: userEmail);
      logInfo('Got ${userTransactions?.length} transactions for the user');
      return userTransactions;
    } catch (e) {
      logError('Error getting transactions for the user. ${e.toString()}');
      return null;
    }
  }

  Future<bool> addTransaction({required Transaction transaction}) async {
    try {
      await _transactionUseCase.addTransaction(transaction: transaction);
      logInfo(
        'Added transaction with key ${transaction.userEmail}-${transaction.dateTime}',
      );
      return true;
    } catch (e) {
      logError('Error adding the transaction. ${e.toString()}');
      return false;
    }
  }

  Future<bool> updateTransaction({required Transaction transaction}) async {
    try {
      await _transactionUseCase.updateTransaction(transaction: transaction);
      logInfo(
        'Updated transaction with key ${transaction.userEmail}-${transaction.dateTime}',
      );
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
        'Deleted transaction with key ${transaction.userEmail}-${transaction.dateTime}',
      );
      return true;
    } catch (e) {
      logError('Error deleting the transaction. ${e.toString()}');
      return false;
    }
  }

  Future<bool> deleteAllUserTransactions({required String userEmail}) async {
    try {
      await _transactionUseCase.deleteAllUserTransactions(userEmail: userEmail);
      logInfo('Emptied transaction list for user');
      return true;
    } catch (e) {
      logError('Error deleting all transactions. ${e.toString()}');
      return false;
    }
  }
}
