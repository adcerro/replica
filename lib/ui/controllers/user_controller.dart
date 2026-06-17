import 'package:get/state_manager.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/domain/repositories/i_user_repository.dart';

import '../../domain/entities/user.dart';

class UserController extends GetxController {
  final IUserRepository _userUseCase;
  UserController({required this._userUseCase});
  Future<User?> getUser({required String email}) async {
    try {
      logInfo('Accessed user with email: $email');
      return _userUseCase.getUser(email: email);
    } catch (e) {
      logError('Error getting user', e);
      return null;
    }
  }

  Future<bool> registerUser({required User user}) async {
    try {
      await _userUseCase.addUser(user: user);
      logInfo('Registered user with email: ${user.getEmail()}');
      return true;
    } catch (e) {
      logError('Error registering user', e);
      return false;
    }
  }

  Future<bool> updateUser({required User user}) async {
    try {
      await _userUseCase.updateUser(user: user);
      logInfo('Updated user with email: ${user.getEmail()}');
      return true;
    } catch (e) {
      logError('Error registering user', e);
      return false;
    }
  }

  Future<bool> deleteUser({required String email}) async {
    try {
      await _userUseCase.deleteUser(email: email);
      logInfo('Deleted user with email: $email');
      return true;
    } catch (e) {
      logError('Error deleting user', e);
      return false;
    }
  }
}
