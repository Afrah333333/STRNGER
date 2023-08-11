import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeModel extends ChangeNotifier {
 late String _currentDate;
 late String _currentTime;

  DateTimeModel() {
    _updateDateTime();
    // Start a timer to update date and time every minute
    Timer.periodic(Duration(minutes: 1), (_) {
      _updateDateTime();
    });
  }

  void _updateDateTime() {
    _currentDate = DateFormat('EEEE, MMMM d, y').format(DateTime.now());
    _currentTime = DateFormat('h:mm a').format(DateTime.now());
    notifyListeners();
  }

  String get currentDate => _currentDate;
  String get currentTime => _currentTime;
}
