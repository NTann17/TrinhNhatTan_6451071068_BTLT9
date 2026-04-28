import '../controllers/auth_controller.dart';
import '../repositories/firebase_auth_repository.dart';

class AuthService {
  AuthService._();

  static final AuthController controller = AuthController(
    FirebaseAuthRepository(),
  );
}