class GuidaValidators {
  static String? fullnameValidator(String? name) {
    if (name!.isEmpty) {
      return 'Enter your fullname';
    } else if (!name.isValidFullName) {
      return 'Enter a valid name';
    }
    return null;
  }

  static String? usernameValidator(String? username) {
    if (username!.isEmpty) {
      return 'Enter a username';
    } else if (!username.isValidUsername) {
      return 'Letters, numbers and underscores only';
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email!.isEmpty) {
      return 'Enter a email';
    } else if (!email.isValidEmail) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? emailOrUsernameValidator(String? emailOrUsername) {
    if (emailOrUsername!.isEmpty) {
      return 'Enter an email address or a username';
    } else if (!emailOrUsername.isValidEmailOrUsername) {
      return 'Enter a valid email/username';
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return 'This field cannot be empty';
    } 
    // else if (!password.isValidPassword) {
    //   return 'Enter a valid password';
    // }
    return null;
  }

  static String? repeatPasswordValidator(String? repeatPassword,
      [String? password]) {
    if (repeatPassword != password) {
      return 'Ensure the passwords are the same';
    } else if (repeatPassword!.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }
}

extension GuidaRegExp on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidFullName {
    final fullNameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return fullNameRegExp.hasMatch(this);
  }

  bool get isValidUsername {
    final usernameRegEx = RegExp(r"^[a-zA-Z0-9_]{3,20}$");
    return usernameRegEx.hasMatch(this);
  }

  bool get isValidEmailOrUsername {
    final emailOrUsername = RegExp(
        r"^(?:(?=.*[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})|(?=^[a-zA-Z0-9_]{3,16}$))[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$|^[a-zA-Z0-9_]{3,16}$");
    return emailOrUsername.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z\d])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegExp.hasMatch(this);
  }
}
