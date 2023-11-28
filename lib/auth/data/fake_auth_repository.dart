import 'package:split_the_bill/auth/data/auth_repository.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/test_data.dart';

class FakeAuthRepository extends AuthRepository {
  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return testUsers.firstWhere((user) => user.email == email);
  }

  @override
  Future<void> register(String email, String password) {
    throw UnimplementedError();
  }
}
