import '../models/app_user.dart';
import '../repositories/auth_repository.dart';

class AuthController {
  AuthController(this._repository);

  final AuthRepository _repository;

  Stream<AppUser?> authStateChanges() {
    return _repository.authStateChanges();
  }

  Future<AppUser> register({
    required String email,
    required String password,
  }) {
    return _repository.register(
      email: email,
      password: password,
    );
  }

  Future<AppUser> login({
    required String email,
    required String password,
  }) {
    return _repository.login(
      email: email,
      password: password,
    );
  }

  Future<void> logout() {
    return _repository.logout();
  }

  AppUser? get currentUser => _repository.currentUser;
}