import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userName;
  final String email;
  final String password;

  User({ required this.password,
    required this.userName,
    required this.email,
  });

  @override
  List<Object?> get props => [ userName, email, password];
}
