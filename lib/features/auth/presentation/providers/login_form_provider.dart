import 'package:flutter_upgop_shop/features/shared/infrastructure/inputs/email.dart';
import 'package:flutter_upgop_shop/features/shared/infrastructure/inputs/password.dart';

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });
}
