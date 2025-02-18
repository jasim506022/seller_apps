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

  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterField(fieldName);
    }
    return null;
  }

  static String? validateProductName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emptyProductName;
    }
    if (value.trim().length < 3) {
      return AppStrings.productNameTooShort;
    }
    if (value.length > 100) {
      return AppStrings.productNameTooLong;
    }
    if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
      return AppStrings.productNameInvalid;
    }
    return null; // ✅ Valid input
  }

  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emptyPrice;
    }
    final double? price = double.tryParse(value);
    if (price == null) {
      return AppStrings.invalidPrice;
    }
    if (price <= 0 && price > 1000000) {
      return AppStrings.priceOutOfRange;
    }

    if (RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value) == false) {
      return AppStrings.invalidPriceFormat;
    }
    return null; // ✅ Valid input
  }

  static String? validateRating(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emptyRating;
    }
    final double? rating = double.tryParse(value);
    if (rating == null) {
      return AppStrings.invalidRating;
    }
    if (rating < 1 || rating > 5) {
      return AppStrings.ratingOutOfRange;
    }
    return null; // Valid input
  }

  static String? validateDiscount(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emptyDiscount;
    }
    final double? discount = double.tryParse(value);
    if (discount == null) {
      return AppStrings.invalidDiscount;
    }
    if (discount < 0) {
      return AppStrings.discountNegative;
    }

    if (discount > 100) {
      return AppStrings.discountOverLimit;
    }
    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
      return AppStrings.invalidDiscountFormat;
    }
    return null; // ✅ Valid input
  }

  static String? validateProductDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emptyDescription;
    }
    if (value.trim().length < 10) {
      return AppStrings.descriptionTooShort;
    }
    if (value.length > 1000) {
      return AppStrings.descriptionTooLong;
    }
    return null; // ✅ Valid input
  }
}

/*
!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)
#: RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value) == false
#:  double? discount = double.tryParse(value);
#: !RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)
*/