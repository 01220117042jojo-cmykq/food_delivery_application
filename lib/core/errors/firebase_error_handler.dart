import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      print("Firebase Error Code: ${error.code}");
      switch (error.code) {
        case 'invalid-credential':
          return 'Email or password is incorrect.';
        case 'channel-error':
          return 'Please fill the all fields.';
        case 'user-not-found':
          return 'No account found with this email.';
        case 'wrong-password':
          return 'Incorrect password, please try again.';
        case 'invalid-email':
          return 'The email address is badly formatted.';
        case 'network-request-failed':
          return 'Please check your internet connection.';
        case 'user-disabled':
          return 'This user has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        case 'email-already-in-use':
          return 'This email is already registered.';
        default:
          return 'An unexpected error occurred';
      }
    }
    return 'Something went wrong, please try again.';
  }
}
