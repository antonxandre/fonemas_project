import 'dart:async';
import '../../domain/models/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  AppUser _currentUser = const AppUser(id: 'test_user', role: 'patient');
  final _controller = StreamController<AppUser>.broadcast();

  MockAuthRepository() {
    _controller.add(_currentUser);
  }

  @override
  Stream<AppUser> get authStateChanges => _controller.stream;

  @override
  AppUser get currentUser => _currentUser;

  @override
  Future<AppUser> signInWithEmailAndPassword(String email, String password) async {
    _currentUser = const AppUser(id: 'test_user', email: 'test@test.com', role: 'patient');
    _controller.add(_currentUser);
    return _currentUser;
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword(String email, String password) async {
    _currentUser = const AppUser(id: 'new_user', email: 'new@test.com', role: 'patient');
    _controller.add(_currentUser);
    return _currentUser;
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    _currentUser = const AppUser(id: 'google_user', displayName: 'Google User', role: 'patient');
    _controller.add(_currentUser);
    return _currentUser;
  }

  @override
  Future<void> signOut() async {
    _currentUser = AppUser.empty();
    _controller.add(_currentUser);
  }
}
