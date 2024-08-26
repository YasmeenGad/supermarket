import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure({required String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  CacheFailure({required String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  NetworkFailure({required String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}

class UnknownFailure extends Failure {
  UnknownFailure({required String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
