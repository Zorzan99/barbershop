import 'package:barbershop/src/core/excceptions/auth_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
