import 'package:flutter/material.dart';
import 'package:crud_app/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Enviroment.initEnv();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
