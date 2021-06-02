import 'dart:async';

import 'package:flutter/services.dart';

class RangersApplogFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('rangers_applog_flutter_plugin');

  /// 初始化SDK，应该尽早初始化，推荐
  /// @param appid  String 上报的AppID.
  /// @param channel  String 渠道.
  /// @host private report URL e.g. https://myprivateurl.com
  /// 使用示例：
  /// FlutterRangersAppLog.initRangersAppLog('159486','test_channel');
  /// 推荐在native端初始化SDK，这样可以采集到更多的信息，而不是Flutter启动后才初始化SDK
  static void initRangersAppLog(String appid, String channel, bool enableAb,
      bool enableEncrypt, bool enableLog, String host) {
    assert(appid != null && appid.isNotEmpty);
    assert(channel != null && channel.isNotEmpty);
    _channel.invokeMethod('initRangersAppLog', {
      "appid": appid,
      "channel": channel,
      "enable_ab": enableAb,
      "enable_encrypt": enableEncrypt,
      "enable_log": enableLog,
      "host": host
    });
  }

  /// 获取device_id
  /// @returns device_id
  /// 使用示例：
  /// String value = await FlutterRangersAppLog.getDeviceId();
  static Future<String> getDeviceId() async {
    return await _channel.invokeMethod('getDeviceId');
  }

  /* AB Test */
  /// 获取ab_sdk_version
  /// @returns ab_sdk_version
  /// 使用示例：
  /// String value = await FlutterRangersAppLog.getAbSdkVersion();
  static Future<String> getAbSdkVersion() async {
    return await _channel.invokeMethod('getAbSdkVersion');
  }

  /// get all ab config
  /// This method will not trigger exposure.
  /// Note: Only avaliable on iOS!
  /// Usage example：
  /// Map<dynamic, dynamic> d = await FlutterRangersAppLog.getAllAbTestConfig();
  static Future<Map<dynamic, dynamic>> getAllAbTestConfig() async {
    return await _channel.invokeMethod('getAllAbTestConfig');
  }

  /// 获取对应key的abConfigValue
  /// @param key  String
  /// @returns 对应abConfigValue
  /// 使用示例：
  /// String value = await FlutterRangersAppLog.getABTestConfigValueForKey('ab_test_key');
  static Future<dynamic> getABTestConfigValueForKey(
      String key, dynamic defaultValue) async {
    return await _channel.invokeMethod(
        'getABTestConfigValueForKey', {'key': key, 'default': defaultValue});
  }

  /// v3埋点上报
  /// @param eventName  String 事件名.
  /// @param params Map<String, dynamic> 事件属性.
  /// 使用示例：
  /// FlutterRangersAppLog.onEventV3('flutter_start',{'key1':'value1','key2':'value2'});
  static void onEventV3(String eventName, Map<String, dynamic> params) {
    assert(eventName != null);
    _channel.invokeMethod("onEventV3", {'event': eventName, 'param': params});
  }

  /* Login and Logout */
  /// 设置user_unique_id
  /// @param userUniqueID String Pass userID you want to log in. Pass null to log out.
  /// 使用示例：
  /// FlutterRangersAppLog.setUserUniqueId('123');
  static void setUserUniqueId(String userUniqueID) {
    _channel.invokeMethod('setUserUniqueId', {'uuid': userUniqueID});
  }

  /* Custom Header */
  /// 自定义header信息
  /// @param params Map<String, dynamic> header信息.
  /// 使用示例：
  /// FlutterRangersAppLog.setHeaderInfo({'key1':'value1','key2':'value2'});
  static void setHeaderInfo(Map<String, dynamic> customHeader) {
    _channel.invokeMethod("setHeaderInfo", {'customHeader': customHeader});
  }

  /* Profile */
  static void profileSet(Map<String, dynamic> profileDict) {
    _channel.invokeMethod('profileSet', {'profileDict': profileDict});
  }

  static void profileSetOnce(Map<String, dynamic> profileDict) {
    _channel.invokeMethod('profileSetOnce', {'profileDict': profileDict});
  }

  static void profileUnset(String key) {
    _channel.invokeMethod('profileUnset', {'key': key});
  }

  static void profileIncrement(Map<String, dynamic> profileDict) {
    _channel.invokeMethod('profileIncrement', {'profileDict': profileDict});
  }

  static void profileAppend(Map<String, dynamic> profileDict) {
    _channel.invokeMethod('profileAppend', {'profileDict': profileDict});
  }
}
