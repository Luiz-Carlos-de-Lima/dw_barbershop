import 'package:dw_barbershop/src/core/constants/local_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/auth_exception.dart';
import '../../core/exceptions/service_exception.dart';
import '../../core/functional_programming/either.dart';
import '../../core/functional_programming/nil.dart';
import '../../repositories/user/user_repository.dart';
import 'user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;

  UserLoginServiceImpl({required this.userRepository});

  @override
  Future<Either<ServiceException, Nil>> execute(String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(Nil());
      case Failure(:final exception):
        switch (exception) {
          case AuthError():
            return Failure(ServiceException(message: 'Erro ao realizar login'));
          case AuthUnauthorizedException():
            return Failure(ServiceException(message: 'Login ou senha inválidos'));
        }
    }
  }
}
