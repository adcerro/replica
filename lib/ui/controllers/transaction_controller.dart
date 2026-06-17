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
      logError('Error getting transactions for the user', e);
      return null;
    }
  }

  Future<bool> addTransaction({required Transaction transaction}) async {
    try {
      await _transactionUseCase.addTransaction(transaction: transaction);
      logInfo('Added transaction with id ${transaction.getId()}');
      return true;
    } catch (e) {
      logError('Error adding the transaction. ', e);
      return false;
    }
  }

  Future<bool> updateTransaction({required Transaction transaction}) async {
    try {
      await _transactionUseCase.updateTransaction(transaction: transaction);
      logInfo('Updated transaction with id ${transaction.getId()}');
      return true;
    } catch (e) {
      logError('Error updating the transaction. ', e);
      return false;
    }
  }

  Future<bool> deleteTransaction({
    required String userEmail,
    required double id,
  }) async {
    try {
      await _transactionUseCase.deleteTransaction(userEmail: userEmail, id: id);
      logInfo('Deleted transaction with id $id');
      return true;
    } catch (e) {
      logError('Error deleting the transaction. ', e);
      return false;
    }
  }

  Future<bool> deleteAllUserTransactions({
    required String userEmail,
    required bool accountDeletion,
  }) async {
    try {
      await _transactionUseCase.deleteAllUserTransactions(
        userEmail: userEmail,
        accountDeletion: accountDeletion,
      );
      accountDeletion
          ? logInfo('User transactions removed completely')
          : logInfo('Emptied transaction list for user');
      return true;
    } catch (e) {
      logError('Error deleting all transactions', e);
      return false;
    }
  }
}
