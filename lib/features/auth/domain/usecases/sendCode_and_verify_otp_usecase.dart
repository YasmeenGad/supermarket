import 'package:dartz/dartz.dart';
import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';

class SendOtpUsecase {
  final AuthRepositories repository;

  SendOtpUsecase({required this.repository});

  Future<Either<String, String>> call(String email) {
    return repository.sendOtp(email);
  }
}

class VerifyOtpUsecase {
  final AuthRepositories repository;

  VerifyOtpUsecase({required this.repository});

  Future<Either<String, String>> call(String otp) {
    return repository.verifyOtp(otp);
  }
}

class ResetPasswordUsecase {
  final AuthRepositories repository;

  ResetPasswordUsecase({required this.repository});

  Future<Either<String, String>> call(String token,String newPassword) {
    return repository.resetPassword(token, newPassword);
  }
}
