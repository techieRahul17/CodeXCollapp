import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> registerWithEmailAndPassword(String email, String password);
  Future<User?> signInWithGoogle();
  Future<void> signOut();
  User? get currentUser;
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      if (kIsWeb){
      final googleProvider = GoogleAuthProvider();
      googleProvider.setCustomParameters({'hd': 'ssn.edu.in', 'prompt': 'select_account',});
      final UserCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
      final user = UserCredential.user;
      if (user?.email == null || !user!.email!.endsWith("@ssn.edu.in")) {
        await FirebaseAuth.instance.signOut();
        throw FirebaseAuthException(
            code: "invalid domain", message: "Only SSN Accounts are allowed");
      }
      return user;
    }
           final googleSignIn = GoogleSignIn(
      hostedDomain: 'ssn.edu.in',
    );

    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'cancelled',
        message: 'Sign-in cancelled',
      );
    }

    if (!googleUser.email.endsWith('@ssn.edu.in')) {
      await googleSignIn.signOut();
      throw FirebaseAuthException(
        code: 'invalid-domain',
        message: 'Only SSN accounts are allowed',
      );
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await _auth.signInWithCredential(credential);

    return userCredential.user; 
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
Future<void> signOut() async {
  await _auth.signOut();
  try {
    await GoogleSignIn().signOut();
  } catch (e) {
        throw _handleAuthException(e);
  }
}
    
  String _handleAuthException(Object e) {
    if (e is FirebaseAuthException) {
      return e.message ?? "An error occurred";
    }
    return "An unexpected error occurred";
  }
}
