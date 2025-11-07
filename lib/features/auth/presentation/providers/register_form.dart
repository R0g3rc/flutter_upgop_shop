import 'package:crud_app/features/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

// 3.- Provider
final registerFormProvider =
    NotifierProvider<RegisterFormNotifier, RegisterFormState>(
      RegisterFormNotifier.new,
    );

// 2.- Notifier
class RegisterFormNotifier extends Notifier<RegisterFormState> {
  @override
  RegisterFormState build() => const RegisterFormState();

  void onFullNameChange(String value) {
    state = state.copyWith(fullName: value);
    _validateForm();
  }

  void onEmailChange(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(email: email);
    _validateForm();
  }

  void onPasswordChange(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(password: password);
    _validateForm();
  }

  void onConfirmPasswordChange(String value) {
    final confirmPassword = Password.dirty(value);
    state = state.copyWith(confirmPassword: confirmPassword);
    _validateForm();
  }

  void _validateForm() {
    final isPasswordMatching =
        state.password.value == state.confirmPassword.value;

    final isFormValid = Formz.validate([
      state.email,
      state.password,
      state.confirmPassword,
    ]);

    state = state.copyWith(
      isValid: isFormValid && isPasswordMatching && state.fullName.isNotEmpty,
    );
  }

  void onRegisterSubmit() async {
    _touchAllFields();
    if (!state.isValid) return;
    print(state);
  }

  _touchAllFields() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = Password.dirty(state.confirmPassword.value);

    // Validations
    final isPasswordMatching = password.value == confirmPassword.value;
    final isFormValid = Formz.validate([email, password, confirmPassword]);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isValid: isFormValid && isPasswordMatching && state.fullName.isNotEmpty,
    );
  }
}

// 1.- State
class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String fullName;
  final Email email;
  final Password password;
  final Password confirmPassword;

  const RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.fullName = '',
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? fullName,
    Email? email,
    Password? password,
    Password? confirmPassword,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
  );

  @override
  String toString() =>
      '''
    RegisterFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      fullName: $fullName
      email: $email
      password: $password
      confirmPassword: $confirmPassword
''';
}
