import 'package:hive_ce/hive_ce.dart';
import 'package:tester/data/datasources/local/i_user_local_datasource.dart';
import 'package:tester/domain/entities/user.dart';

class UserLocalDataSource implements IUserLocalDataSource {
  final _box = Hive.box<User>('users');
  @override
  Future<void> addUser({required User user}) async {
    for (User usr in _box.values) {
      if (usr.getEmail() == user.getEmail()) {
        throw Exception('Email Already in use');
      }
    }
    await _box.put(user.getEmail(), user);
  }

  @override
  Future<void> deleteUser({required String email}) async {
    for (User usr in _box.values) {
      if (usr.getEmail() == email) {
        await _box.delete(email);
      }
    }
    throw Exception('User does not exist');
  }

  @override
  Future<User?> getUser({required String email}) async {
    return _box.get(email);
  }

  @override
  Future<void> updateUser({required User user}) async {
    for (User usr in _box.values) {
      if (usr.getEmail() == user.getEmail()) {
        await _box.put(user.getEmail(), user);
      }
    }
    throw Exception('User does not exist!');
  }
}
