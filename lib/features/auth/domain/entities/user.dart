import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String userName;
  final String email;
  final String password;

  User({ required this.password,
    required this.id,
    required this.userName,
    required this.email,
  });

  @override
  List<Object?> get props => [id, userName, email, password];
}
