import 'package:tester/domain/entities/transaction.dart';

abstract class ITransactionLocalDatasource {
  Future<List<Transaction>> getUserTransactions({required String userEmail});

  Future<void> addTransaction({required Transaction transaction});

  Future<void> updateTransaction({required Transaction transaction});

  Future<void> deleteTransaction({required Transaction transaction});

  Future<void> deleteAllUserTransactions({required String userEmail});
}
