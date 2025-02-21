import 'app_string.dart';

/// **Validation Utility Class**
/// Provides consistent validation logic throughout the app.
class Validators {
  /// **Checks if a string is null or empty after trimming.**
  static bool _isEmpty(String? value) => value?.trim().isEmpty ?? true;

  /// **Predefined regex patterns for validation.**
  static final RegExp _emailPattern =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp _namePattern = RegExp(r'^[a-zA-Z\s]+$');
  static final RegExp _productNamePattern = RegExp(r'^[a-zA-Z0-9 ]+$');
  static final RegExp _decimalPattern = RegExp(r'^\d+(\.\d{1,2})?$');

  /// **Validates an email address.**
  static String? validateEmail(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppStrings.emptyEmail;
    if (!_emailPattern.hasMatch(trimmedValue!)) {
      return AppStrings.invalidEmailFormat;
    }
    return trimmedValue.length > 320 ? AppStrings.emailTooLong : null;
  }

  /// **Validates a password.**
  static String? validatePassword(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppStrings.emptyPassword;
    if (trimmedValue!.length < 6) return AppStrings.passwordTooShort;
    if (!trimmedValue.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.passwordUppercase;
    }
    if (!trimmedValue.contains(RegExp(r'[a-z]'))) {
      return AppStrings.passwordLowercase;
    }
    if (!trimmedValue.contains(RegExp(r'\d'))) return AppStrings.passwordNumber;
    return trimmedValue.length > 20 ? AppStrings.passwordTooLong : null;
  }

  /// **Validates confirm password.**
  static String? validateConfirmPassword(String? value, String password) {
    return _isEmpty(value)
        ? AppStrings.confirmPasswordRequired
        : (value!.trim() != password ? AppStrings.passwordMismatch : null);
  }

  /// **Validates a name (only letters & spaces).**
  static String? validateName(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppStrings.emptyName;
    if (trimmedValue!.length < 2) return AppStrings.nameTooShort;
    if (trimmedValue.length > 50) return AppStrings.nameTooLong;
    return _namePattern.hasMatch(trimmedValue) ? null : AppStrings.nameInvalid;
  }

  /// **Validates a product name.**
  static String? validateProductName(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppStrings.emptyProductName;
    if (trimmedValue!.length < 3) return AppStrings.productNameTooShort;
    if (trimmedValue.length > 100) return AppStrings.productNameTooLong;
    return _productNamePattern.hasMatch(trimmedValue)
        ? null
        : AppStrings.productNameInvalid;
  }

  /// **Validates a price.**
  static String? validatePrice(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppStrings.emptyPrice;
    final price = double.tryParse(trimmedValue!);
    if (price == null || price <= 0 || price > 1000000) {
      return AppStrings.priceOutOfRange;
    }
    return _decimalPattern.hasMatch(trimmedValue)
        ? null
        : AppStrings.invalidPriceFormat;
  }

  /// **Validates a rating (1 to 5).**
  static String? validateRating(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppStrings.emptyRating;
    final rating = double.tryParse(trimmedValue!);
    return (rating == null || rating < 1 || rating > 5)
        ? AppStrings.ratingOutOfRange
        : null;
  }

  /// **Validates a discount percentage (0-100).**
  static String? validateDiscount(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppStrings.emptyDiscount;
    final discount = double.tryParse(trimmedValue!);
    if (discount == null || discount < 0 || discount > 100) {
      return AppStrings.discountOverLimit;
    }
    return _decimalPattern.hasMatch(trimmedValue)
        ? null
        : AppStrings.invalidDiscountFormat;
  }

  /// **Validates a product description.**
  static String? validateProductDescription(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppStrings.emptyDescription;
    if (trimmedValue!.length < 10) return AppStrings.descriptionTooShort;
    if (trimmedValue.length > 1000) return AppStrings.descriptionTooLong;
    return null;
  }

  /// **Validates an address.**
  static String? validateAddress(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppStrings.emptyAddress;
    if (trimmedValue!.length < 5) return AppStrings.addressTooShort;
    if (trimmedValue.length > 200) return AppStrings.addressTooLong;
    return null;
  }
}


/*
#: String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
#: !RegExp(r'[A-Z]').hasMatch(value)
!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)
#: RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value) == false
#:  double? discount = double.tryParse(value);
#: !RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)

#:   static bool _isEmpty(String? value) => value?.trim().isEmpty ?? true;
  why use this instead of 
 if (value == null || value.trim().isEmpty) {
      return AppStrings.emptyEmail;
    } 




*/


/*
import 'app_string.dart';

/// **Validation Utility Class**
/// - Provides validation methods for user inputs.
/// - Ensures consistent validation logic throughout the app.
class Validators {
  /// **Validates an email address.**
  /// - Checks if the email is empty.
  /// - Ensures the email format is valid.

  /// Checks if a string is null or empty after trimming.
  static bool _isEmpty(String? value) => value?.trim().isEmpty ?? true;

  /// **Validates an email address.**
  static String? validateEmail(String? value) {
    if (_isEmpty(value)) return AppStrings.emptyEmail;

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(emailPattern).hasMatch(value!)) {
      return AppStrings.invalidEmailFormat;
    }

    return value.length > 320 ? AppStrings.emailTooLong : null; // ✅ Valid input
  }

  /// **Validates a password.**
  static String? validatePassword(String? value) {
    if (_isEmpty(value)) return AppStrings.emptyPassword;
    if (value!.length < 6) return AppStrings.passwordTooShort;

    if (!RegExp(r'[A-Z]').hasMatch(value)) return AppStrings.passwordUppercase;
    if (!RegExp(r'[a-z]').hasMatch(value)) return AppStrings.passwordLowercase;
    if (!RegExp(r'\d').hasMatch(value)) return AppStrings.passwordNumber;

    return value.length > 20
        ? AppStrings.passwordTooLong
        : null; // ✅ Valid input
  }

  /// **Validates confirm password.**
  static String? validateConfirmPassword(String? value, String password) {
    if (_isEmpty(value)) return AppStrings.confirmPasswordRequired;
    return value != password ? AppStrings.passwordMismatch : null;
  }

  /// **Validates a name (only letters & spaces).**
  static String? validateName(String? value) {
    if (_isEmpty(value)) return AppStrings.emptyName;

    value = value!.trim();
    if (value.length < 2) return AppStrings.nameTooShort;
    if (value.length > 50) return AppStrings.nameTooLong;
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return AppStrings.nameInvalid;
    }

    return null;
  }

  /// **Validates a product name.**
  static String? validateProductName(String? value) {
    if (_isEmpty(value)) return AppStrings.emptyProductName;

    value = value!.trim();
    if (value.length < 3) return AppStrings.productNameTooShort;
    if (value.length > 100) return AppStrings.productNameTooLong;
    if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
      return AppStrings.productNameInvalid;
    }

    return null;
  }

  /// **Validates a price.**
  static String? validatePrice(String? value) {
    if (_isEmpty(value)) return AppStrings.emptyPrice;

    final double? price = double.tryParse(value!);
    if (price == null) return AppStrings.invalidPrice;
    if (price <= 0 || price > 1000000) return AppStrings.priceOutOfRange;

    return RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)
        ? null
        : AppStrings.invalidPriceFormat;
  }

  /// **Validates a rating (1 to 5).**
  static String? validateRating(String? value) {
    if (_isEmpty(value)) return AppStrings.emptyRating;

    final double? rating = double.tryParse(value!);
    if (rating == null) return AppStrings.invalidRating;

    return (rating < 1 || rating > 5) ? AppStrings.ratingOutOfRange : null;
  }

  /// **Validates a discount percentage (0-100).**
  static String? validateDiscount(String? value) {
    if (_isEmpty(value)) return AppStrings.emptyDiscount;

    final double? discount = double.tryParse(value!);
    if (discount == null) return AppStrings.invalidDiscount;
    if (discount < 0) return AppStrings.discountNegative;
    if (discount > 100) return AppStrings.discountOverLimit;

    return RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)
        ? null
        : AppStrings.invalidDiscountFormat;
  }

  /// **Validates a product description.**
  static String? validateProductDescription(String? value) {
    if (_isEmpty(value)) return AppStrings.emptyDescription;

    value = value!.trim();
    if (value.length < 10) return AppStrings.descriptionTooShort;
    if (value.length > 1000) return AppStrings.descriptionTooLong;

    return null;
  }

  /// **Validates an address.**
  static String? validateAddress(String? value) {
    if (_isEmpty(value)) return AppStrings.emptyAddress;

    value = value!.trim();
    if (value.length < 5) return AppStrings.addressTooShort;
    if (value.length > 200) return AppStrings.addressTooLong;

    return null;
  }
}
*/