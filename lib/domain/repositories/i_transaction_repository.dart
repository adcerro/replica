import 'package:tester/domain/entities/transaction.dart';

abstract class ITransactionRepository {
  Future<List<Transaction>?> getUserTransactions({required String userEmail});

  Future<void> addTransaction({required Transaction transaction});

  Future<void> updateTransaction({required Transaction transaction});

  Future<void> deleteTransaction({
    required String userEmail,
    required double id,
  });

  Future<void> deleteAllUserTransactions({
    required String userEmail,
    required bool accountDeletion,
  });
}
