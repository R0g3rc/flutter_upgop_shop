import 'package:crud_app/features/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 3.1.- Provider Repository
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final dataSource = AuthDatasourceImpl();
  return AuthRepositoryImpl(dataSource);
});

// 3.-  Provider Principal
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

// 2.- Notifier
class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository authRepository;

  @override
  AuthState build() {
    authRepository = ref.watch(authRepositoryProvider);
    return AuthState();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentials {
      logout("Wrong Credentials");
    } on ConnectionTimeout {
      logout('Connection Timeout');
    } catch (e) {
      logout("Uncontrolled Error");
    }
  }

  Future<void> registerUser(
    String fullName,
    String email,
    String password,
  ) async {}

  Future<void> checkAuthStatus() async {}

  _setLoggedUser(User user) {
    // TODO: Save user token
    state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);
  }

  Future<void> logout([String? errorMessage]) async {
    // TODO: Clean user token
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
