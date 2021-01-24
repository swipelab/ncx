
import 'dart:async';

import 'package:flutter/services.dart';

class Sys {
  static const MethodChannel _channel =
      const MethodChannel('co.swipelab.ncx.sys');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List<String>> get directory async {
    //TOOD:
    await _channel.invokeMethod('directory');
    return [];
  }
}
