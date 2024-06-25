import 'package:supermarket/features/auth/domain/entities/user.dart';

abstract class AuthRepositories {
  Future<User> login(String email, String password);
  Future<User> register(String userName, String email, String password);
}
