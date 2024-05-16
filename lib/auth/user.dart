import 'package:split_the_bill/constants/constants.dart';

class User {
  final String id;
  final String email;
  final String username;
  final String profileImgPath;

  String getDisplayName() {
    return username.isNotEmpty ? username : email;
  }

  String getImagePath() {
    if (profileImgPath.isNotEmpty) {
      return '${Constants.baseScheme}://${Constants.baseApiUrl}:${Constants.basePort}$profileImgPath';
    } else {
      return '';
    }
  }

//<editor-fold desc="Data Methods">
  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.profileImgPath,
  });

  factory User.getDefault() {
    return const User(
      id: '0',
      email: '',
      username: '',
      profileImgPath: '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          username == other.username &&
          profileImgPath == other.profileImgPath);

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      username.hashCode ^
      profileImgPath.hashCode;

  @override
  String toString() {
    return 'User{ id: $id, email: $email,} username: $username,} profileImgPath: $profileImgPath,}';
  }

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? profileImgPath,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      profileImgPath: profileImgPath ?? this.profileImgPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'profileImgPath': profileImgPath,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      profileImgPath: map['profileImgPath'] as String,
    );
  }

//</editor-fold>
}
