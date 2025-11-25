import 'package:crud_app/features/auth/auth.dart';
import 'package:crud_app/features/shared/infraestructure/services/key_storage.dart';
import 'package:crud_app/features/shared/infraestructure/services/key_storage_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 3.-  Provider Principal
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

// 3.1.- Provider Repository
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final dataSource = AuthDatasourceImpl();
  return AuthRepositoryImpl(dataSource);
});

// 3.2 Key Storage
final keyStorageProvider = Provider<KeyStorageImpl>((ref) {
  final keyStorage = KeyStorageImpl();
  return keyStorage;
});

// 2.- Notifier
class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository authRepository;
  late final KeyStorageService keyStorage;

  @override
  AuthState build() {
    authRepository = ref.watch(authRepositoryProvider);
    keyStorage = ref.watch(keyStorageProvider);
    checkAuthStatus();
    return AuthState();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout("Error no controlado");
    }
  }

  Future<void> registerUser(
    String email,
    String password,
    String fullName,
  ) async {
    await Future.delayed(Duration(milliseconds: 500));
    try {
      final newUser = await authRepository.register(email, password, fullName);
      _setLoggedUser(newUser);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout("Error no controlado");
    }
  }

  Future<void> checkAuthStatus() async {
    final token = await keyStorage.getValue<String>('token');
    if (token == null) {
      return logout();
    }
    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  _setLoggedUser(User user) async {
    await keyStorage.setKeyValue('token', user.token);
    state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);
  }

  Future<void> logout([String? errorMessage]) async {
    await keyStorage.removeKey('token');
    state = state.copyWith(
      authStatus: AuthStatus.unauthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
}

// 1.- State
enum AuthStatus { checking, authenticated, unauthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
