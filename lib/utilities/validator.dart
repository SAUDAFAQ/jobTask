class Validators {
  static final RegExp _validNameRegExp = RegExp(r'[0-9]');

  static bool isValidName(String name) {
    return _validNameRegExp.hasMatch(name) == true || name.isEmpty
        ? true
        : false;
  }

  static bool isValidPassword(String password) {
    return password.length < 8 ? false : true;
  }
}
