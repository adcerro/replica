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
  Future<void> deleteAllUserTransactions({
    required String userEmail,
    required bool accountDeletion,
  }) async => _transactionLocalDataSource.deleteAllUserTransactions(
    userEmail: userEmail,
    accountDeletion: accountDeletion,
  );

  @override
  Future<void> deleteTransaction({
    required String userEmail,
    required double id,
  }) async => _transactionLocalDataSource.deleteTransaction(
    userEmail: userEmail,
    id: id,
  );

  @override
  Future<List<Transaction>?> getUserTransactions({
    required String userEmail,
  }) async =>
      _transactionLocalDataSource.getUserTransactions(userEmail: userEmail);

  @override
  Future<void> updateTransaction({required Transaction transaction}) async =>
      _transactionLocalDataSource.updateTransaction(transaction: transaction);
}
