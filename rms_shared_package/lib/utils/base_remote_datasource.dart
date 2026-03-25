import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'error_handler.dart';

/// A mixin that provides common error handling and logging for remote data sources.
mixin BaseRemoteDataSource {
  /// Wraps a remote call with error handling, logging, and timeout.
  ///
  /// [taskName] is used for logging purposes.
  /// [timeoutDuration] defaults to 15 seconds.
  Future<T> performSafeCall<T>(
    Future<T> Function() call, {
    required String taskName,
    Duration timeoutDuration = const Duration(seconds: 15),
  }) async {
    try {
      log('[$taskName] -> starting operation', name: taskName);

      final result = await call().timeout(timeoutDuration);

      log('[$taskName] <- success', name: taskName);
      return result;
    } on FirebaseAuthException catch (e) {
      _logError(taskName, 'Auth error: [${e.code}] ${e.message}', e);
      throw Exception(ErrorHandler.getFriendlyMessage(e));
    } on FirebaseException catch (e) {
      _logError(taskName, 'Firestore error: [${e.code}] ${e.message}', e);
      throw Exception(ErrorHandler.getFriendlyMessage(e));
    } on SocketException catch (e) {
      _logError(taskName, 'Network error: $e');
      throw Exception(ErrorHandler.getFriendlyMessage(e));
    } on TimeoutException catch (e) {
      _logError(taskName, 'Timeout error: $e');
      throw Exception('Request timed out. Please check your connection.');
    } catch (e) {
      _logError(taskName, 'Unknown error: $e', e);
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred: $e');
    }
  }

  void _logError(String taskName, String message, [dynamic error]) {
    log('[$taskName] <- $message', name: taskName, error: error);
  }
}
