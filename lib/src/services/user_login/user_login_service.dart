import '../../core/exceptions/service_exception.dart';
import '../../core/functional_programming/either.dart';
import '../../core/functional_programming/nil.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}
