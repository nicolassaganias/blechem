import 'package:flutter/foundation.dart';

class Logger {
  static log(dynamic) {
    if (kDebugMode) {
      // dev.log(dynamic.toString());
      print('---DEV--- $dynamic');
    }
  }
}
