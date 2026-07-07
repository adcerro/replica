import 'dart:math';

import 'package:bcrypt/bcrypt.dart';
import 'package:get/state_manager.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/domain/entities/category_info.dart';
import 'package:tester/domain/repositories/i_user_repository.dart';

import '../../domain/entities/user.dart';

class UserController extends GetxController {
  final IUserRepository _userUseCase;
  User? _loggedUser;

  UserController({required this._userUseCase});

  /// The password param must be a normal String of the password.
  Future<User?> logUser({
    required String email,
    required String password,
  }) async {
    _loggedUser = await _userUseCase.getUser(email: email);
    if (_loggedUser != null &&
        BCrypt.checkpw(password, _loggedUser!.password)) {
      logInfo('Accessed user with email: $email');
      return _loggedUser;
    }
    logError('User/Password error');
    return null;
  }

  User? getLoggedUser() {
    return _loggedUser;
  }

  Future<void> addCategory({
    required String categoryName,
    required String categoryIcon,
    required double categoryBudget,
  }) async {
    if (_loggedUser == null) {
      logError('No logged user to add category.');
      return;
    }
    if (_loggedUser!.categories.containsKey(categoryName)) {
      logError('Category already exists.');
      return;
    }
    _loggedUser!.categories[categoryName] = CategoryInfo(
      color: 0xFF000000 | Random().nextInt(0xFFFFFF),
      icon: categoryIcon,
      budget: categoryBudget,
    );
    await _userUseCase.updateUser(user: _loggedUser!);
    logInfo('Added category $categoryName to user ${_loggedUser!.email}');
  }

  void logOut() {
    _loggedUser = null;
    logInfo('Logged out');
  }

  Future<void> registerGuest({
    required double income,
    required double budget,
  }) async {
    await registerUser(
      user: User(
        name: 'guest',
        email: 'guest@user',
        password: 'guestpass',
        income: income,
        budget: budget,
      ),
    );
    _loggedUser = await logUser(email: 'guest@user', password: 'guestpass');
  }

  /// The user password will get
  Future<bool> registerUser({required User user}) async {
    try {
      user.password = BCrypt.hashpw(user.password, BCrypt.gensalt());
      await _userUseCase.addUser(user: user);
      logInfo('Registered user with email: ${user.email}');
      return true;
    } catch (e) {
      logError('Error registering user: ${e.toString()}');
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
      logInfo('Updated user with email: ${user.email}');
      _loggedUser = user;
      return true;
    } catch (e) {
      logError('Error updating user: ${e.toString()}');
      return false;
    }
  }

  /// The logged user would be the deleted one.
  Future<bool> deleteUser({required String email}) async {
    if (_loggedUser == null || _loggedUser!.email != email) {
      logError('logged user Unauthorized');
      return false;
    }
    try {
      await _userUseCase.deleteUser(email: email);
      logInfo('Deleted user with email: $email');
      _loggedUser = null;
      return true;
    } catch (e) {
      logError('Error deleting user: ${e.toString()}');
      return false;
    }
  }
}
