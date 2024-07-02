import 'package:dartz/dartz.dart';

abstract class AuthRepositories {
  Future<Either<String, String>> login(String email, String password);
  Future<Either<String, String>> register(String userName, String email, String password);
  Future<Either<String, String>> sendOtp(String email);
  Future<Either<String, String>> verifyOtp(String otp);
  Future<Either<String, String>> resetPassword(String token,String newPassword);
}