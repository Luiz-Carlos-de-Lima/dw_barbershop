import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_programming/either.dart';
import '../../core/exceptions/auth_exception.dart';
import '../../models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();
}
