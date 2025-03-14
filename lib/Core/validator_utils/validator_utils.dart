class ValidatorUtils {
  static String? name(String? v, {String? requiredMessage, String? invalidMessage}) {
    if (v == null || v.trim().isEmpty) {
      return requiredMessage ?? 'Name required!';
    }
    if (!RegExp(r"^[\p{L} ,.'-]*$", unicode: true).hasMatch(v)) {
      return invalidMessage ?? 'Invalid name!';
    }
    return null;
  }
  // static String? name(String? v) {
  //   if (v == null || v
  //       .trim()
  //       .isEmpty) {
  //     return 'Name required!';
  //   } else if (!RegExp(
  //       r"^[\p{L} ,.'-]*$", caseSensitive: false, unicode: true, dotAll: true)
  //       .hasMatch(v)) {
  //     return 'Invalid name!';
  //   }
  //   return null;
  // }

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
}