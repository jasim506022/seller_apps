import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../model/app_exception.dart';

class InternetException extends AppException {
  InternetException(String? message)
      : super(
          "No Internet Exception",
          message!,
        );
}

class FileSystemExceptions extends AppException {
  FileSystemExceptions(String? message)
      : super(
          "File System Error",
          "Failed to access the file: $message",
        );
}

class OutOfMemoryErrors extends AppException {
  OutOfMemoryErrors(String? message)
      : super(
          "Memory Error",
          "Not enough memory to pick an image.",
        );
}

class TimeOutExceptions extends AppException {
  TimeOutExceptions(String? message)
      : super(
          "Timeout Error",
          "The request timed out. Please try again.",
        );
}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message])
      : super(
          'Request Time out',
          message,
        );
}

class PlatformExceptions extends AppException {
  final PlatformException exception;
  PlatformExceptions(this.exception) : super() {
    _setMessgeAndDetails();
  }

  void _setMessgeAndDetails() {
    switch (exception.code) {
      case 'camera_access_denied':
        title = 'Permission Denied';
        message = "Camera or photo library access denied.";
        break;
      case 'photo_library_access_denied':
        title = 'Permission Denied';
        message = "Camera or photo library access denied.";
        break;
      case 'camera_unavailable':
        title = "Camera Unavailable";
        message = "Camera is not available on this device.";
        break;
      default:
        title = "Platform Error";
        message = "Failed to pick image: ${exception.message}";
    }
  }
}

class FirebaseExceptions extends AppException {
  final FirebaseException exception;
  FirebaseExceptions(this.exception) : super() {
    handleFirebaseException(exception);
  }

  void handleFirebaseException(FirebaseException e) {
    // Handling different Firebase errors
    switch (e.code) {
      case 'canceled':
        title = 'Upload Canceled';
        message = 'The file upload was canceled.';
        break;
      case 'quota-exceeded':
        title = 'Storage Limit Reached';
        message = 'You have exceeded your storage quota.';
        break;
      case 'unknown':
        title = 'Unknown Error';
        message = 'An unknown error occurred: ${e.message}';
        break;
      case 'unauthorized':
        title = 'Unauthorized';
        message = 'You do not have permission to perform this action.';
        break;
      case 'retry-limit-exceeded':
        title = 'Retry Limit Exceeded';
        message = 'The maximum number of retries has been reached.';
        break;
      case 'invalid-checksum':
        title = 'Invalid Checksum';
        message = 'The file upload failed due to an invalid checksum.';
        break;
      case 'permission-denied':
        title = 'Permission Denied';
        message = 'You do not have permission to access this data.';
        break;

      case 'unavailable':
        title = 'Service Unavailable';
        message =
            'The service is temporarily unavailable. Please try again later.';
        break;
      case 'deadline-exceeded':
        title = 'Timeout';
        message = 'The request took too long to complete. Please try again.';
        break;
      default:
        title = 'Firebase Error';
        message = 'Failed to upload image: ${e.message}';
    }
  }
}

class FirebaseAuthExceptions extends AppException {
  final FirebaseAuthException exception;

  FirebaseAuthExceptions(this.exception) : super() {
    _setMessageAndDetails();
  }

  void _setMessageAndDetails() {
    switch (exception.code) {
      case 'email-already-in-use':
        title = 'Email Already in Use';
        message = 'Email already in use. Please use another email';
        break;
      case 'wrong-password':
        title = 'Incorrect Password';
        message = 'Password incorrect. Please check your password';
        break;
      case 'invalid-email':
        title = 'invalid-email';
        message = 'invalid-email-title';
        break;
      case 'invalid-credential':
        message =
            'Invalid email or password. Please check your credentials and try again.';
        title = 'Check Email or Password';
        break;
      case 'network-request-failed':
        title = "Network Request Failed";
        message = "Network error. Please check your internet connection.";
        break;
      case 'weak-password':
        message = 'Weak password. Please enter a stronger password.';
        title = 'Invalid Password';
        break;
      case 'too-many-requests':
        message = 'Too many requests. Please try again later.';
        title = 'Too Many Requests';
        break;
      case 'operation-not-allowed':
        message = 'This operation is not allowed.';
        title = 'Operation Not Allowed';
        break;
      case 'user-disabled':
        message = 'This user has been disabled.';
        title = 'User Disabled';
        break;
      case 'user-not-found':
        message = 'No user found with this email.';
        title = 'User Not Found';
        break;

        case 'invalid-user-token':
        message = 'The users token is invalid or expired';
        title = 'Invalid User Token';
        break;
      default:
        message = 'Please check your internet connection or other issues.';
        title = 'Error Occurred';
        break;
    }
  }
}

class OthersException extends AppException {
  OthersException([String? message]) : super('Other Exception', message);
}