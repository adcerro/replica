import 'package:bcrypt/bcrypt.dart';
import 'package:get/state_manager.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/domain/repositories/i_user_repository.dart';

import '../../domain/entities/user.dart';

class UserController extends GetxController {
  final IUserRepository _userUseCase;
  User? _loggedUser;

  UserController({required this._userUseCase});

  /// The password must be a String hashed by BCrypt.
  Future<User?> logUser({
    required String email,
    required String password,
  }) async {
    _loggedUser = await _userUseCase.getUser(email: email);
    if (_loggedUser != null &&
        BCrypt.checkpw(password, _loggedUser!.getPassword())) {
      logInfo('Accessed user with email: $email');
      return _loggedUser;
    }
    logError('User/Password error');
    return null;
  }

  User? getLoggedUser() {
    return _loggedUser;
  }

  void logOut() {
    _loggedUser = null;
    logInfo('Logged out');
  }

  Future<void> guestUserMode({
    required double income,
    required double budget,
  }) async {
    _loggedUser = await logUser(
      email: 'guest@user',
      password: BCrypt.hashpw('', BCrypt.gensalt()),
    );
    if (_loggedUser != null) {
      logInfo('Logged in as local user');
      return;
    }
    registerUser(
      user: User(
        email: 'guest@user',
        password: '',
        income: income,
        budget: budget,
      ),
    );
    _loggedUser = await logUser(
      email: 'guest@user',
      password: BCrypt.hashpw('', BCrypt.gensalt()),
    );
  }

  /// The user password will get
  Future<bool> registerUser({required User user}) async {
    try {
      user.setPassword(
        newPass: BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()),
      );
      await _userUseCase.addUser(user: user);
      logInfo('Registered user with email: ${user.getEmail()}');
      return true;
    } catch (e) {
      logError('Error registering user', e);
      return false;
    }
  }

  /// Expects password to be hashed in the received user
  /// as well as the user being updated being the logged one
  Future<bool> updateUser({required User user}) async {
    if (_loggedUser == null) {
      logError('No logged user to update.');
      return false;
    }
    try {
      await _userUseCase.updateUser(user: user);
      logInfo('Updated user with email: ${user.getEmail()}');
      _loggedUser = user;
      return true;
    } catch (e) {
      logError('Error updating user', e);
      return false;
    }
  }

  /// The logged user would be the deleted one.
  Future<bool> deleteUser({required String email}) async {
    if (_loggedUser == null || _loggedUser!.getEmail() != email) {
      logError('logged user Unauthorized');
      return false;
    }
    try {
      await _userUseCase.deleteUser(email: email);
      logInfo('Deleted user with email: $email');
      _loggedUser = null;
      return true;
    } catch (e) {
      logError('Error deleting user', e);
      return false;
    }
  }
}
