import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  RegisterEvent({required this.userName, required this.email, required this.password});

  @override
  List<Object?> get props => [userName, email, password];
}

class SendResetCodeEvent extends AuthEvent {
  final String email;

  SendResetCodeEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;

  VerifyOtpEvent({required this.otp});

  @override
  List<Object?> get props => [otp];
}

class ResetPasswordEvent extends AuthEvent {
  final String token;
  final String newPassword;

  ResetPasswordEvent({required this.token, required this.newPassword});

  @override
  List<Object?> get props => [token, newPassword];
}

class CreateCustomerEvent extends AuthEvent {
  final String name;

  CreateCustomerEvent({required this.name});

  @override
  List<Object?> get props => [name];
}
class NavigateToLoginEvent extends AuthEvent {}
