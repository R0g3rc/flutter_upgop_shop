import 'package:crud_app/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;

  AuthStatus get authStatus => _authStatus;

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.authStatusNotifier.addListener(() {
      _authStatus = _authNotifier.authStatusNotifier.value;
      notifyListeners();
    });
  }
}
