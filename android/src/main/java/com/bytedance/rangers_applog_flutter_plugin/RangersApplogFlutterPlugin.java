package com.bytedance.rangers_applog_flutter_plugin;

import com.bytedance.applog.AppLog;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** RangersApplogFlutterPlugin */
public class RangersApplogFlutterPlugin implements MethodCallHandler {

  private static final String TAG = "RangersApplogFlutter";

  private static final String FlutterPluginMethodGetDeviceId = "getDeviceId";
  private static final String FlutterPluginMethodGetAbSdkVersion = "getAbSdkVersion";
  private static final String FlutterPluginMethodGetABTestConfigValueForKey = "getABTestConfigValueForKey";
  private static final String FlutterPluginMethodOnEventV3 = "onEventV3";
  private static final String FlutterPluginMethodSetUserUniqueId = "setUserUniqueId";
  private static final String FlutterPluginMethodSetHeaderInfo = "setHeaderInfo";

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "rangers_applog_flutter_plugin");
    channel.setMethodCallHandler(new RangersApplogFlutterPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case FlutterPluginMethodGetDeviceId:
        result.success(AppLog.getDid());
        break;
      case FlutterPluginMethodGetAbSdkVersion:
        result.success(AppLog.getAbSdkVersion());
        break;
      case FlutterPluginMethodGetABTestConfigValueForKey:
        result.success(AppLog.getAbConfig((String) call.argument("key"), call.argument("default")));
        break;
      case FlutterPluginMethodOnEventV3:
        String eventName = (String) call.argument("event");
        HashMap<String, Object> paramMap = (HashMap<String, Object>) call.argument("param");
        JSONObject paramJson = new JSONObject();
        for (Map.Entry<String, Object> entry : paramMap.entrySet()) {
          try {
            paramJson.put(entry.getKey(), entry.getValue());
          } catch (JSONException e) {
          }
        }
        AppLog.onEventV3(eventName, paramJson);
        break;
      case FlutterPluginMethodSetUserUniqueId:
        AppLog.setUserUniqueID((String) call.argument("uuid"));
        break;
      case FlutterPluginMethodSetHeaderInfo:
        AppLog.setHeaderInfo((HashMap<String, Object>) call.argument("customHeader"));
        break;
      default:
        result.notImplemented();
        break;
    }
  }
}
