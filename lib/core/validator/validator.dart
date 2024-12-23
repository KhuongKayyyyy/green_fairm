class Validator {
  static isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static isValidPassword(String password) {
    return password.length >= 3;
  }
}
