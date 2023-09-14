import '../../core/functional_programming/either.dart';
import '../../core/exceptions/auth_exception.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
