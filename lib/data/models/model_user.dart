
import '/../domain/entities/entity_user.dart';

class UserModel extends User {
  UserModel({required super.username, required super.email, required super.password});
// Factory method untuk konversi dari Map ke objek User
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }

// Method untuk konversi dari objek User ke Map
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}