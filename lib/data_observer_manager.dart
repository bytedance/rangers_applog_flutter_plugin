
import 'dart:async';

import 'package:flutter/services.dart';

class DataObserverManager {

  DataObserverManager._();

  static const EventChannel _eventChannel = const EventChannel("com.bytedance.applog/data_observer");
  static late Stream _eventChannelStream;
  static late Stream _abTestConfigStream;
  static late Stream _abVidsChangeStream;
  static bool _init = false;

  static init() {
    _ensureInit();
  }

  static dispose() {
    
  }

  static _ensureInit() {
    if (!_init) {
      _eventChannelStream = _eventChannel.receiveBroadcastStream();
      _abTestConfigStream = _eventChannelStream.where((event) {
        return event == "onABTestSuccess";
      });
      _abVidsChangeStream = _eventChannelStream.where((event) {
        return event == "onABTestVidsChanged";
      });
      _init = true;
    }
  }

  static Stream<dynamic> receiveABTestConfigStream() {
    _ensureInit();
    return _abTestConfigStream;
  }

  static Stream<dynamic> receiveABVidsChangeStream() {
    _ensureInit();
    return _abVidsChangeStream;
  }
}