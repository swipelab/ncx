import 'dart:async';

import 'package:flutter/services.dart';

class Sys {
  static const MethodChannel _channel =
      const MethodChannel('co.swipelab.ncx.sys');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Map<String, dynamic>> fsDirectory(String path) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      'fs::directory',
      <String, dynamic>{
        "path": path,
      },
    );

    return result;
  }
}
