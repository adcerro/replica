import 'package:tester/domain/entities/transaction.dart';

abstract class IMoneyMovementLocalDatasource {
  Future<List<Transaction>> getUserMovements({required String user});

  Future<void> addMovement({required Transaction movement});

  Future<void> updateMovement({required Transaction movement});

  Future<void> deleteMovement({required double id});
}
