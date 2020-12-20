import 'dart:async';

import 'package:flutter/services.dart';

class RangersApplogFlutterPlugin {
  static const MethodChannel _channel = const MethodChannel('rangers_applog_flutter_plugin');
  static const String RangersAppLogVendorCN = 'CN'; /// 中国
  static const String RangersAppLogVendorSG = 'SG'; /// 新加坡
  static const String RangersAppLogVendorVA = 'VA'; /// 美东

  /// 初始化SDK，应该尽早初始化，推荐
  /// @param appID  String 上报的AppID.
  /// @param userUniqueID  String 登录的账号ID.
  /// 使用示例：
  /// FlutterRangersAppLog.startTrack('159486','test_app_name');
  /// 推荐在native端初始化SDK，这样可以采集到更多的信息，而不是Flutter启动后才初始化SDK
  static void startTrack (String appID, String appName, [String channel = 'App Store', String vendor = RangersAppLogVendorCN])  {
    List<dynamic> args = [appID, appName, channel, vendor];
    _channel.invokeMethod('startTrack',args);
  }

  /// 获取SDK版本
  /// @returns SDK版本
  /// 使用示例：
  /// String sdkVersion = await FlutterRangersAppLog.sdkVersion;
  static Future<String> get sdkVersion async {
    final String version = await _channel.invokeMethod('sdkVersion');
    return version;
  }

  /// 获取byteDanceDeviceID
  /// @param appID  String 上报的AppID.
  /// @returns 对应AppID的byteDanceDeviceID
  /// 使用示例：
  /// String value = await FlutterRangersAppLog.byteDanceDeviceID('159486');
  static Future<String> byteDanceDeviceID (String appID) async {
    List<dynamic> args = [appID];
    final String value = await _channel.invokeMethod('byteDanceDeviceID',args);
    return value;
  }

  /// 获取byteDanceInstallID
  /// @param appID  String 上报的AppID.
  /// @returns 对应AppID的byteDanceInstallID
  /// 使用示例：
  /// String value = await FlutterRangersAppLog.byteDanceInstallID('159486');
  static Future<String> byteDanceInstallID (String appID) async {
    List<dynamic> args = [appID];
    final String value = await _channel.invokeMethod('byteDanceInstallID',args);
    return value;
  }

  /// 获取byteDanceSSID
  /// @param appID  String 上报的AppID.
  /// @returns 对应AppID的byteDanceSSID
  /// 使用示例：
  /// String value = await FlutterRangersAppLog.byteDanceSSID('159486');
  static Future<String> byteDanceSSID (String appID) async {
    List<dynamic> args = [appID];
    final String value = await _channel.invokeMethod('byteDanceSSID',args);
    return value;
  }

  /// 获取userUniqueID
  /// @param appID  String 上报的AppID.
  /// @returns 对应AppID的userUniqueID
  /// 使用示例：
  /// String value = await FlutterRangersAppLog.userUniqueID('159486');
  static Future<String> userUniqueID (String appID) async {
    List<dynamic> args = [appID];
    final String value = await _channel.invokeMethod('userUniqueID',args);
    return value;
  }

  /// 登录
  /// @param appID  String 上报的AppID.
  /// @param userUniqueID  String 登录的账号ID.
  /// 使用示例：
  /// FlutterRangersAppLog.login('159486','123');
  static void login (String appID ,String userUniqueID)  {
    List<dynamic> args = [appID, userUniqueID];
    _channel.invokeMethod('login',args);
  }


  /// 登录
  /// @param appID  String 上报的AppID.
  /// 使用示例：
  /// FlutterRangersAppLog.logout('159486');
  static void logout (String appID)  {
    List<dynamic> args = [appID];
    _channel.invokeMethod('logout',args);
  }

  /// 埋点上报
  /// @param appID  String 上报的AppID.
  /// @param eventName  String 事件名.
  /// @param params Map<String,dynamic> 事件属性.
  /// 使用示例：
  /// FlutterRangersAppLog.eventV3('159486','flutter_start',{'key1':'value1','key2':'value2'});
  static void eventV3(String appID ,String eventName ,Map<String,dynamic> params) {
    assert(appID != null);
    assert(eventName != null);
    List<dynamic> args = [appID, eventName, params];
    _channel.invokeMethod("eventV3",args);
  }

  /// 获取ABTest Value
  /// @param appID  String 上报的AppID.
  /// @param key String ABTest目标key.
  /// @returns ABTest对应key的Value
  /// 使用示例：
  /// FlutterRangersAppLog.abTestValue('159486','button_color');
  static Future<dynamic> abTestValue(String appID ,String key) async {
    assert(appID != null);
    assert(key != null);
    List<dynamic> args = [appID, key];
    final dynamic value = await _channel.invokeMethod("abTestValue",args);
    return value;
  }

  /// 设置ABTestSDKVersion
  /// @param appID  String 上报的AppID.
  /// 使用示例：
  /// FlutterRangersAppLog.abSDKVersion('159486','123');
  static void abSDKVersion(String appID ,String abSDKVersion) async {
    assert(appID != null);
    List<dynamic> args = [appID, abSDKVersion];
    _channel.invokeMethod("abSDKVersion",args);
  }

  /// 激活用户
  /// @param appID  String 上报的AppID.
  /// 使用示例：
  /// FlutterRangersAppLog.activeUser('159486');
  static void activeUser(String appID) async {
    assert(appID != null);
    List<dynamic> args = [appID];
    _channel.invokeMethod("activeUser",args);
  }

  /// UI事件，无埋点上报接口预留
  /// @param appID  String 上报的AppID.
  /// @param eventName  String 事件名.
  /// @param params Map<String,dynamic> 事件属性.
  /// 使用示例：
  /// FlutterRangersAppLog.trackUIEvent('159486','bav_click',{'key1':'value1','key2':'value2'});
  static void trackUIEvent(String appID ,String eventName ,Map<String,dynamic> params) {
    assert(eventName != null);
    List<dynamic> args = [appID, eventName, params];
    _channel.invokeMethod("trackUIEvent",args);
  }

  static bool enableDebugLog = false;
  static bool enableAb = false;
  static String reportUrl = null;

  /// 初始化SDK，应该尽早初始化，推荐
  /// @param appid  String 上报的AppID.
  /// @param channel  String 渠道.
  /// 使用示例：
  /// FlutterRangersAppLog.initRangersAppLog('159486','test_channel');
  /// 推荐在native端初始化SDK，这样可以采集到更多的信息，而不是Flutter启动后才初始化SDK
  static void initRangersAppLog(String appid, String channel) {
    assert(appid != null && appid.isNotEmpty);
    assert(channel != null && channel.isNotEmpty);
    _channel.invokeMethod('initRangersAppLog', {
      "appid":appid,
      "channel":channel,
      "enableLog":enableDebugLog,
      "enableAb":enableAb,
      "reportUrl":reportUrl,
    });
  }

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
