import 'app_function.dart';
import 'app_string.dart';

/// **Validation Utility Class**
/// - Provides validation methods for user inputs.
/// - Ensures consistent validation logic throughout the app.
class Validators {
  /// **Validates an email address.**
  /// - Checks if the email is empty.
  /// - Ensures the email format is valid.
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppStrings.enterEmailAddress;
    }
    if (!AppsFunction.isValidEmail(email)) {
      return AppStrings.validEmailAddress;
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.enterPassword;
    } else if (password.length < 6) {
      return AppStrings.validPassword;
    }
    return null;
  }

  // Validation for non-empty fields.
  static String? validateNameEmpty(String? value) {
    if (value == null || value.isEmpty) return AppStrings.enterName;
    if (value.length < 4) return AppStrings.nameValid;
    return null;
  }

  // Validation for confirm password field.
  static String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterConfirmPassword;
    } else if (value.length < 6) {
      return AppStrings.validConfirmPassword;
    }
    return null;
  }

  static String? validateProductNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "${AppStrings.pleaseEnterProduct} $fieldName.";
    }
    return null;
  }

  static String? validateProductName(String? value) {
    if (value == null || value.isEmpty)
      return AppStrings.pleaseEnterProductName;
    if (value.length <= 2) {
      return AppStrings.productNameMustBe3Characters;
    }
    return null;
  }

  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterField(fieldName);
    }
    return null;
  }
}
