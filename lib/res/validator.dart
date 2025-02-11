import 'app_function.dart';
import 'app_string.dart';

class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppString.enterEmailAddress;
    } else if (!AppsFunction.isValidEmail(email)) {
      return AppString.validEmailAddress;
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppString.enterPassword;
    } else if (password.length < 6) {
      return AppString.validPassword;
    }
    return null;
  }

  // Validation for non-empty fields.
  static String? validateNameEmpty(String? value) {
    if (value == null || value.isEmpty) return AppString.enterName;
    if (value.length < 4) return AppString.nameValid;
    return null;
  }

  // Validation for confirm password field.
  static String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.enterConfirmPassword;
    } else if (value.length < 6) {
      return AppString.validConfirmPassword;
    }
    return null;
  }

  static String? validateProductNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "${AppString.pleaseEnterProduct} $fieldName.";
    }
    return null;
  }

  static String? validateProductName(String? value) {
    if (value == null || value.isEmpty) return AppString.pleaseEnterProductName;
    if (value.length <= 2) {
      return AppString.productNameMustbe2Charactoer;
    }
    return null;
  }

  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return AppString.pleaseEnterField(fieldName);
    }
    return null;
  }
}
