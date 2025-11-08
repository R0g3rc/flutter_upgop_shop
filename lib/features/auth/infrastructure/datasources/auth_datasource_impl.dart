import 'package:crud_app/config/config.dart';
import 'package:crud_app/features/auth/auth.dart';

class AuthDatasourceImpl extends AuthDataSource {
  @override
  Future<User> checkStatus(String token) async {
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'pasword': password},
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (e) {
      throw WrongCredentials();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    throw UnimplementedError();
  }
}
