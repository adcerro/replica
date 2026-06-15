import 'package:tester/domain/entities/transaction.dart';

abstract class IMoneyMovementLocalDatasource {
  Future<List<Transaction>> getUserTransaction({required String user});

  Future<void> addTransaction({required Transaction transaction});

  Future<void> updateTransaction({required Transaction transaction});

  Future<void> deleteTransaction({required double id});
}
