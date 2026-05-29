import '../models/app_user.dart';

abstract class AuthRepository {
  /// Stream of authentication state changes.
  Stream<AppUser> get authStateChanges;

  /// Get current user synchronously
  AppUser get currentUser;

  /// Sign in with email and password
  Future<AppUser> signInWithEmailAndPassword(String email, String password);

  /// Create a new account with email and password
  Future<AppUser> createUserWithEmailAndPassword(String email, String password);

  /// Sign in with Google
  Future<AppUser> signInWithGoogle();

  /// Sign out
  Future<void> signOut();
}
