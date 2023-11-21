// TODO: Use Freezed or json_serializable
class User {
  final String id;
  final String username;
  final String email;

//<editor-fold desc="Data Methods">
  const User({
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          email == other.email);

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'User{ id: $id, username: $username, email: $email,}';
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
    );
  }

//</editor-fold>
}
