import 'package:crud_app/features/auth/auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;
  AuthRepositoryImpl(AuthDataSource? dataSource)
    : dataSource = dataSource ?? AuthDatasourceImpl();

  @override
  Future<User> checkStatus(String token) {
    return dataSource.checkStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return dataSource.register(email, password, fullName);
  }
}
