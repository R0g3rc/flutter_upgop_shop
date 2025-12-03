import 'package:crud_app/config/router/app_router_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:crud_app/features/auth/auth.dart';
import 'package:crud_app/features/products/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Check Auth Status
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(path: '/', builder: (context, state) => const ProductsScreen()),
    ],
    redirect: (context, state) {
      final isTo = state.uri;
      final isAuth = goRouterNotifier.authStatus;
      if (isTo.path == '/splash' && isAuth == AuthStatus.checking) return null;
      if (isAuth == AuthStatus.unauthenticated) {
        if (isTo.path == '/login' || isTo.path == '/register') return null;
        return '/login';
      }
      if (isAuth == AuthStatus.authenticated) {
        if (isTo.path == '/login' ||
            isTo.path == '/register' ||
            isTo.path == '/splash') {
          return '/';
        }
      }
      return null;
    },
  );
});
