part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}

class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess(this.message);

  @override
  List<Object> get props => [message];
}
class AuthLoadingResetPassword extends AuthState {}

class AuthFailureResetPassword extends AuthState {
  final String error;

  const AuthFailureResetPassword(this.error);

  @override
  List<Object> get props => [error];
}

class AuthSuccessResetPassword extends AuthState {
  final String token;

  const AuthSuccessResetPassword(this.token);

  @override
  List<Object> get props => [token];
}

class CustomerLoading extends AuthState {}

class CustomerLoaded extends AuthState {
  final Customer customer;
  CustomerLoaded({required this.customer});

  @override
  List<Object> get props => [customer];
}

class CustomerError extends AuthState {
  final String message;

  CustomerError({required this.message});

  @override
  List<Object> get props => [message];
}
