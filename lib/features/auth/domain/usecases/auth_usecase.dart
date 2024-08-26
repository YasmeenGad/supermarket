import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';


typedef StringResult =  Either<Failure, String>;

class AuthUsecase{
  final AuthRepositories authRepositories;
 const  AuthUsecase({required this.authRepositories});

 Future<StringResult> login(String email, String password)async{
  return await authRepositories.login(email, password);
 }

 Future<StringResult> register(String userName, String email, String password)async{
  return await authRepositories.register(userName, email, password);
 }

 Future<StringResult> sendOtp(String email)async{
   return await authRepositories.sendOtp(email);
 }

 Future<StringResult> verifyOtp(String otp)async{
   return await authRepositories.verifyOtp(otp);
 }

 Future<StringResult> resetPassword(String token,String newPassword)async{
   return await authRepositories.resetPassword(token, newPassword);
 }
}
