import 'dart:async';

import 'package:flutter/services.dart';

class RangersApplogFlutterPlugin {
  static const MethodChannel _channel = const MethodChannel('rangers_applog_flutter_plugin');

  /// 获取device_id
  /// @returns device_id
  /// 使用示例：
  /// String value = await FlutterRangersAppLog.getDeviceId();
  static Future<String> getDeviceId() async {
    return await _channel.invokeMethod('getDeviceId');
  }

  /// 获取ab_sdk_version
  /// @returns ab_sdk_version
  /// 使用示例：
  /// String value = await FlutterRangersAppLog.getAbSdkVersion();
  static Future<String> getAbSdkVersion() async {
    return await _channel.invokeMethod('getAbSdkVersion');
  }

  /// 获取对应key的abConfigValue
  /// @param key  String
  /// @returns 对应abConfigValue
  /// 使用示例：
  /// String value = await FlutterRangersAppLog.getABTestConfigValueForKey('ab_test_key');
  static Future<String> getABTestConfigValueForKey(String key, dynamic defaultValue) async {
    return await _channel.invokeMethod('getABTestConfigValueForKey', {'key':key, 'default':defaultValue});
  }

  /// v3埋点上报
  /// @param eventName  String 事件名.
  /// @param params Map<String, dynamic> 事件属性.
  /// 使用示例：
  /// FlutterRangersAppLog.onEventV3('flutter_start',{'key1':'value1','key2':'value2'});
  static void onEventV3(String eventName, Map<String, dynamic> params) {
    assert(eventName != null);
    _channel.invokeMethod("onEventV3", {'event':eventName,'param':params});
  }

  /// 设置user_unique_id
  /// @param userUniqueID  String 登录的账号ID.
  /// 使用示例：
  /// FlutterRangersAppLog.setUserUniqueId('123');
  static void setUserUniqueId(String userUniqueID) {
    _channel.invokeMethod('setUserUniqueId', {'uuid':userUniqueID});
  }

  /// 自定义header信息
  /// @param params Map<String, dynamic> header信息.
  /// 使用示例：
  /// FlutterRangersAppLog.setHeaderInfo({'key1':'value1','key2':'value2'});
  static void setHeaderInfo(Map<String, dynamic> customHeader) {
    _channel.invokeMethod("setHeaderInfo", {'customHeader':customHeader});
  }
}
