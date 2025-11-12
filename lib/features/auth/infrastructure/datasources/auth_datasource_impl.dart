import 'package:crud_app/config/config.dart';
import 'package:crud_app/features/auth/auth.dart';
import 'package:dio/dio.dart';

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
        data: {'email': email, 'password': password},
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw WrongCredentials();
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeout();
      }
      throw CustomError('Unexpected Error', 500);
    } catch (e) {
      throw CustomError("Unhandled Error", 500);
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    throw UnimplementedError();
  }
}
