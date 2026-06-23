import 'package:tester/data/datasources/local/i_transaction_local_datasource.dart';
import 'package:tester/domain/entities/transaction.dart' show Transaction;
import 'package:tester/domain/repositories/i_transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  final ITransactionLocalDatasource _transactionLocalDataSource;
  TransactionRepository({required this._transactionLocalDataSource});
  @override
  Future<void> addTransaction({required Transaction transaction}) async =>
      _transactionLocalDataSource.addTransaction(transaction: transaction);

  @override
  Future<void> deleteAllUserTransactions({required String userEmail}) async =>
      _transactionLocalDataSource.deleteAllUserTransactions(
        userEmail: userEmail,
      );

  @override
  Future<void> deleteTransaction({required Transaction transaction}) async =>
      _transactionLocalDataSource.deleteTransaction(transaction: transaction);

  @override
  Future<List<Transaction>?> getUserTransactions({
    required String userEmail,
  }) async =>
      _transactionLocalDataSource.getUserTransactions(userEmail: userEmail);

  @override
  Future<void> updateTransaction({required Transaction transaction}) async =>
      _transactionLocalDataSource.updateTransaction(transaction: transaction);
}
