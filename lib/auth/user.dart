class User {
  final String id;
  final String email;

//<editor-fold desc="Data Methods">
  const User({
    required this.id,
    required this.email,
  });

  factory User.getDefault() {
    return const User(
      id: '0',
      email: '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email);

  @override
  int get hashCode => id.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'User{' + ' id: $id,' + ' email: $email,' + '}';
  }

  User copyWith({
    String? id,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
    );
  }

//</editor-fold>
}
