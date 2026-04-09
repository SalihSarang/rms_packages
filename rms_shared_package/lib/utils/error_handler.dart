import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

/// A utility class for handling and formatting errors.
class ErrorHandler {
  /// Maps various exceptions to user-friendly error messages.
  static String getFriendlyMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      return _getAuthErrorMessage(error.code);
    } else if (error is FirebaseException) {
      return _getFirestoreErrorMessage(error.code);
    } else if (error is SocketException) {
      return 'Please check your internet connection and try again.';
    } else if (error is Exception) {
      final errorStr = error.toString();
      if (errorStr.contains('SocketException') ||
          errorStr.contains('connection')) {
        return 'Network error. Please check your internet connection.';
      }
      return 'Something went wrong. Please try again later.';
    }

    return 'An unexpected error occurred. Please try again.';
  }

  /// Maps Firebase Authentication error codes to user-friendly messages.
  static String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Invalid password. Please try again.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'operation-not-allowed':
        return 'Server error. Please contact support.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'invalid-credential':
        return 'Invalid credentials. Please double-check your email and password.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  /// Maps Cloud Firestore error codes to user-friendly messages.
  static String _getFirestoreErrorMessage(String code) {
    switch (code) {
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'unavailable':
        return 'The service is temporarily unavailable. Please try again later.';
      case 'deadline-exceeded':
        return 'The request timed out. Please check your connection.';
      case 'not-found':
        return 'The requested information was not found.';
      case 'already-exists':
        return 'This item already exists.';
      default:
        return 'Data operation failed. Please try again.';
    }
  }
}
