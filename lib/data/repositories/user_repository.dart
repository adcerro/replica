import 'package:tester/data/datasources/local/i_user_local_datasource.dart';
import 'package:tester/domain/entities/user.dart' show User;
import 'package:tester/domain/repositories/i_user_repository.dart';

class UserRepository implements IUserRepository {
  final IUserLocalDataSource _userLocalDataSource;
  UserRepository({required this._userLocalDataSource});
  @override
  Future<void> addUser({required User user}) async =>
      await _userLocalDataSource.addUser(user: user);

  @override
  Future<void> deleteUser({required String email}) async =>
      await _userLocalDataSource.deleteUser(email: email);

  @override
  Future<User?> getUser({required String email}) async =>
      await _userLocalDataSource.getUser(email: email);

  @override
  Future<void> updateUser({required User user}) async =>
      await _userLocalDataSource.updateUser(user: user);
}
