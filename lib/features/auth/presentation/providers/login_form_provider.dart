import 'package:crud_app/features/shared/infraestructure/inputs/inputs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

// 3.- Provider
final loginFormProvider = NotifierProvider<LoginFormNotifier, LoginFormState>(
  LoginFormNotifier.new,
);

// 2.- Notifier
class LoginFormNotifier extends Notifier<LoginFormState> {
  @override
  LoginFormState build() => LoginFormState();

  void onEmailChange(String value) {
    final Email newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  void onPasswordChange(String value) {
    final Password newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.password]),
    );
  }

  void onLoginSubmit() {
    _touchAllFields();
    if (!state.isValid) return;
    print(state);
  }

  _touchAllFields() {
    final Email email = Email.dirty(state.email.value);
    final Password password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password]),
    );
  }
}

// 1.- State
class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  const LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  @override
  String toString() =>
      '''
    LoginFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      email: $email
      password: $password
''';
}
