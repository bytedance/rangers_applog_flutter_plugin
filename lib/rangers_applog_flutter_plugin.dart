import 'dart:async';

import 'package:flutter/services.dart';

class RangersApplogFlutterPlugin {
  static const MethodChannel _channel = const MethodChannel('rangers_applog_flutter_plugin');
  // static const String RangersAppLogVendorCN = 'CN'; /// 中国
  // static const String RangersAppLogVendorSG = 'SG'; /// 新加坡
  /// 是否显示Debug Log。生产环境勿打开。
  static bool enableDebugLog = false;
  /// 是否开启ABTest
  static bool enableAb = false;
  /// reportUrl String 自定义上报Host。私有化部署才配置。
  static String reportUrl = null;

  /// 初始化SDK。应该尽早初始化。
  /// @param appid  String 上报的AppID.
  /// @param channel  String 分发渠道. 一般iOS和安卓的channel是不同的。iOS一般为App Store。
  /// 使用示例：
  /// FlutterRangersAppLog.initRangersAppLog('159486','App Store');
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
  static Future<String> getABTestConfigValueForKey(String key) async {
    return await _channel.invokeMethod('getABTestConfigValueForKey', {'key':key});
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
