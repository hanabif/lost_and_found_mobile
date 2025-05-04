import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  User? _user;
  bool _isAuthenticated = false;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  // Sign Up
  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Implement actual signup logic with your backend
      // For now, we'll simulate a successful signup
      await Future.delayed(const Duration(seconds: 1));

      _user = User(
        id: 'temp_user_id',
        email: email,
        fullName: fullName,
        createdAt: DateTime.now(),
      );
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign In
  Future<bool> signIn({required String email, required String password}) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Implement actual signin logic with your backend
      // For now, we'll simulate a successful signin
      await Future.delayed(const Duration(seconds: 1));

      _user = User(
        id: 'temp_user_id',
        email: email,
        fullName: 'Test User', // This should come from your backend
        createdAt: DateTime.now(),
      );
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement actual signout logic with your backend
      await Future.delayed(const Duration(seconds: 1));

      _user = null;
      _isAuthenticated = false;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
