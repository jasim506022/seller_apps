import 'app_string.dart';

/// **Validation Utility Class**
/// - Provides validation methods for user inputs.
/// - Ensures consistent validation logic throughout the app.
class Validators {
  /// **Validates an email address.**
  /// - Checks if the email is empty.
  /// - Ensures the email format is valid.

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emptyEmail;
    }
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(emailPattern).hasMatch(value)) {
      return AppStrings.invalidEmailFormat;
    }
    if (value.length > 320) {
      return AppStrings.emailTooLong;
    }
    return null; // ✅ Valid input
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emptyPassword;
    }
    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return AppStrings.passwordUppercase;
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return AppStrings.passwordLowercase;
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return AppStrings.passwordNumber;
    }

    if (value.length > 20) {
      return AppStrings.passwordTooLong;
    }
    return null; // ✅ Valid input
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password.";
    }
    if (value != password) {
      return "Passwords do not match. Please re-enter.";
    }
    return null; // ✅ Valid input
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
    if (price <= 0 || price > 1000000) {
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

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your name.";
    }
    if (value.trim().length < 2) {
      return "Name must be at least 2 characters long.";
    }
    if (value.length > 50) {
      return "Name cannot exceed 50 characters.";
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return "Name can only contain letters and spaces.";
    }
    return null; // ✅ Valid input
  }

  String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your address.";
    }
    if (value.trim().length < 5) {
      return "Address must be at least 5 characters long.";
    }
    if (value.length > 200) {
      return "Address cannot exceed 200 characters.";
    }
    return null; // ✅ Valid input
  }
}

/*
#: String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
#: !RegExp(r'[A-Z]').hasMatch(value)
!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)
#: RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value) == false
#:  double? discount = double.tryParse(value);
#: !RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)
*/