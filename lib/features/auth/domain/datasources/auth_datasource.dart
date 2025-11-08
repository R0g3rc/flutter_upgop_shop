import 'package:crud_app/features/auth/auth.dart';

abstract class AuthDataSource {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
  Future<User> checkStatus(String token);
}
