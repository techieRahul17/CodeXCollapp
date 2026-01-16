
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../application/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch auth controller state
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState is AsyncLoading;

    // Listen to changes for redirect / errors
    ref.listen(authControllerProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            context.go('/home'); // Redirect on successful login
          }
        },
        loading: () {},
        error: (err, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.toString())),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: ElevatedButton.icon(
          onPressed: isLoading
              ? null
              : () {
                  // Call Google sign-in
                  ref.read(authControllerProvider.notifier).signInWithGoogle();
                },
          icon: Image.asset('/assets/google.png', height: 22),
          label: Text(isLoading ? 'Signing in...' : 'Sign in with Google'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
      ),
    );
  }
}
