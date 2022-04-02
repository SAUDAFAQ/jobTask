class Validators {
  static final RegExp _validNameRegExp = RegExp(r'[0-9]');

  static bool isValidName(String name) {
    return _validNameRegExp.hasMatch(name) == true ? true : false;
  }
}
