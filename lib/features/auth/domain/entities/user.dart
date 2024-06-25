import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String userName;
  final String email;
  final String password;

  const User(
      {required this.id,
      required this.userName,
      required this.email,
      required this.password});

  @override
  List<Object?> get props => [id, userName, email, password];
}
