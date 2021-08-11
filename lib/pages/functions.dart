import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class Functions {
  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePhoneNo(String value) {
    if (!GetUtils.isPhoneNumber(value)) {
      return "Provide valid Phone Number";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  // bool checkLogin() {
  //   final isValid = loginFormKey.currentState!.validate();
  //   if (!isValid) {
  //     return false;
  //   } else {
  //     loginFormKey.currentState!.save();
  //     return true;
  //   }
  // }
}
