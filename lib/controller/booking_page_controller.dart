import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BookingPageController extends GetxController {
  DateTime? currentDatein = DateTime.now();
  DateTime? currentDateout;
  TimeOfDay? curentTimein = TimeOfDay.now();
  TimeOfDay? currentTimeout;
  late DateTime initialOut;
  void updateDateIn(DateTime? pickedDate) {
    currentDatein = pickedDate;
    initialOut = pickedDate!;
    update();
  }

  void updateDateOut(DateTime? pickedDate) {
    currentDateout = pickedDate;
    update();
  }

  void updateTimeIn(TimeOfDay? pickedTime) {
    curentTimein = pickedTime;
    update();
  }

  void updateTimeout(TimeOfDay? pickedTime) {
    currentTimeout = pickedTime;
    update();
  }
}
