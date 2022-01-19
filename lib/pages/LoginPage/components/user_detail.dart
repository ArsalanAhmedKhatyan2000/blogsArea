class UserDetails {
  static String? _userID;
  static String? _email;
  static String? _name;
  static String? _phoneNumber;
  static String? _password;
  // UserDetails({
  //   @required userID,
  //   @required email,
  //   @required name,
  //   @required phoneNumber,
  // })  : _userID = userID,
  //       _email = email,
  //       _name = name,
  //       _phoneNumber = phoneNumber;

  static void setUserID({String? userID}) {
    _userID = userID!;
  }

  static void setEmail({String? email}) {
    _email = email!;
  }

  static void setName({String? name}) {
    _name = name!;
  }

  static void setPhoneNumber({String? phoneNumber}) {
    _phoneNumber = phoneNumber!;
  }

  static void setPassword({String? password}) {
    _password = password!;
  }

  static String? getUserID() {
    return _userID;
  }

  static String? getEmail() {
    return _email;
  }

  static String? getName() {
    return _name;
  }

  static String? getPhoneNumber() {
    return _phoneNumber;
  }

  static String? getPassword() {
    return _password;
  }
}
