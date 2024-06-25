import 'package:supermarket/features/auth/domain/entities/user.dart';

// ignore: must_be_immutable
class UserModel extends User{

  String id;
  String username;
  String email;

  UserModel(this.id, this.username, this.email) : super(id: id, username: username, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['id'],
      json['username'],
      json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}