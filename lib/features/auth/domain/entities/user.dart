import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String password;

  User({ required this.password,
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  List<Object?> get props => [id, username, email, password];
}
