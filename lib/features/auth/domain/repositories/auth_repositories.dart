import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';

abstract class AuthRepositories {
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, String>> register(String userName, String email, String password);
  Future<Either<Failure, String>> sendOtp(String email);
  Future<Either<Failure, String>> verifyOtp(String otp);
  Future<Either<Failure, String>> resetPassword(String token,String newPassword);
}