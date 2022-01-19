import 'package:flutter/material.dart';

class FieldValidations {
  static bool validationOnButton({FormState? key}) {
    if (key!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  static String? isEmail({String? value}) {
    String fieldValue = value.toString().trim();

    const String regexPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regExp = RegExp(regexPattern);

    if (fieldValue.isEmpty) {
      return "Please enter your email address";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "Invalid Email Address";
    }

    return null;
  }

  static String? isPassword({String? value}) {
    String fieldValue = value.toString().trim();
    if (fieldValue.isEmpty) {
      return "Please enter your password";
    } else if (fieldValue.length > 15) {
      return "Password can't be greater than 15 characters";
    }
    return null;
  }

  static String? isBlogTitle({String? value}) {
    String fieldValue = value.toString().trim();
    if (fieldValue.isEmpty) {
      return "Please enter your blog title";
    } else if (fieldValue.length > 50) {
      return "Blog title can't be greater than 50 characters";
    }
    return null;
  }

  static String? isBlogDescription({String? value}) {
    String fieldValue = value.toString().trim();
    if (fieldValue.isEmpty) {
      return "Please enter your blog Description";
    }
    return null;
  }

  static String? isPhoneNumber({String? value}) {
    String fieldValue = value.toString().trim();
    const String regexPattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final RegExp regExp = RegExp(regexPattern);
    if (fieldValue.isEmpty) {
      return "Please enter your phone number";
    } else if (fieldValue.length > 11 ||
        fieldValue.length < 11 ||
        fieldValue.length != 11) {
      return "Invalid phone number";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "Invalid phone number";
    }
    return null;
  }

  static String? isName({String? value}) {
    String fieldValue = value.toString().trim();
    const String regexPattern = r'[a-zA-Z]';
    final RegExp regExp = RegExp(regexPattern);
    if (fieldValue.isEmpty) {
      return "Please enter your name";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "Invalid name";
    }
    return null;
  }
}
