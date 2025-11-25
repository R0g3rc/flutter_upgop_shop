import 'package:crud_app/config/config.dart';
import 'package:crud_app/features/auth/auth.dart';
import 'package:dio/dio.dart';

class AuthDatasourceImpl extends AuthDataSource {
  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dioCfg.get(
        '/auth/check-status',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data["message"] ?? "Token no válido");
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError("Error de conexión");
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dioCfg.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError("Credenciales Incorrectas");
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError("Error de conexión");
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    try {
      final response = await dioCfg.post(
        "/auth/register",
        data: {"email": email, "password": password, "fullName": fullName},
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      throw CustomError(e.response?.data["message"]);
    } catch (e) {
      throw Exception();
    }
  }
}
