class ValidatorUtils {
  static String? name(String? v, {String? requiredMessage, String? invalidMessage}) {
    if (v == null || v.trim().isEmpty) {
      return requiredMessage ?? 'Name required!';
    }
    if (!RegExp(r"^[\p{L}0-9 ,.'-]*$", unicode: true).hasMatch(v)) {
      return invalidMessage ?? 'Invalid name!';
    }
    return null;
  }

  static String? email(String? v) {
    if (v == null || v
        .trim()
        .isEmpty) {
      return 'Email required!';
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(v)) {
      return 'Invalid email!';
    }
    return null;
  }

  static String? phone(String? v) {
    if (v == null || v
        .trim()
        .isEmpty) {
      return 'Phone number required!';
    } else if (!RegExp(
        r"^01[0-25]\d{8}$")
        .hasMatch(v)) {
      return 'Invalid phone number!';
    }
    return null;
  }

  static String? password(String? v) {
    if (v == null || v
        .trim()
        .isEmpty) {
      return 'Password required!';
    } else if (!RegExp(r'^(?=.*?[0-9]).{8,}$').hasMatch(v)) {
      return 'Invalid password!';
    }
    return null;
  }

  static String? birthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a birth date';
    }
    final RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dateRegExp.hasMatch(value)) {
      return 'Please enter date in YYYY-MM-DD format';
    }
    try {
      final parts = value.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);
      final date = DateTime(year, month, day);
      if (date.year != year || date.month != month || date.day != day) {
        return 'Invalid date';
      }
      if (date.isBefore(DateTime(2024))) {
        return 'Date must be after 2023';
      }
    } catch (e) {
      return 'Invalid date format';
    }
    return null;
  }

}