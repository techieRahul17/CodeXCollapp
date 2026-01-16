import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return FirebaseAuthRepository();
}

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<User?> build() async {
    // Initial auth state (already logged in or not)
    return ref.read(authRepositoryProvider).currentUser;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return ref.read(authRepositoryProvider).signInWithGoogle();
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signOut();
      return null;
    });
  }
}

