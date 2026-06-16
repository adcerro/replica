import 'package:tester/domain/entities/user.dart';

abstract class IUserRepository {
  Future<User?> getUser({required String email});

  Future<void> addUser({required User user});

  Future<void> updateUser({required User user});

  Future<void> deleteUser({required String email});
}
