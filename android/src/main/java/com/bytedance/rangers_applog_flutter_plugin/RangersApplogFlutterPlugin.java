package com.bytedance.rangers_applog_flutter_plugin;

import android.app.Activity;
import android.util.Log;

import com.bytedance.applog.AppLog;
import com.bytedance.applog.ILogger;
import com.bytedance.applog.InitConfig;
import com.bytedance.applog.UriConfig;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * RangersApplogFlutterPlugin
 */
public class RangersApplogFlutterPlugin implements MethodCallHandler {

    private static final String TAG = "RangersApplogFlutter";

    private static final String FlutterPluginMethodInitRangersApplog = "initRangersAppLog";
    private static final String FlutterPluginMethodGetDeviceId = "getDeviceId";
    private static final String FlutterPluginMethodGetAbSdkVersion = "getAbSdkVersion";
    private static final String FlutterPluginMethodGetABTestConfigValueForKey = "getABTestConfigValueForKey";
    private static final String FlutterPluginMethodOnEventV3 = "onEventV3";
    private static final String FlutterPluginMethodSetUserUniqueId = "setUserUniqueId";
    private static final String FlutterPluginMethodSetHeaderInfo = "setHeaderInfo";

    private Activity activity;

    private RangersApplogFlutterPlugin(Activity activity) {
        this.activity = activity;
    }

    private RangersApplogFlutterPlugin() {

    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "rangers_applog_flutter_plugin");
        channel.setMethodCallHandler(new RangersApplogFlutterPlugin(registrar.activity()));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case FlutterPluginMethodInitRangersApplog:
                Log.e(TAG, "appid="+(String) call.argument("appid")+", channel="+(String) call.argument("channel")+
                        ", enableAb="+(Boolean) call.argument("enableAb")+
                        ", enable_encrypt="+(Boolean) call.argument("enable_encrypt")+
                        ", enable_log="+(Boolean) call.argument("enable_log")+
                        ", host="+(String) call.argument("host") );
                InitConfig initConfig = new InitConfig((String) call.argument("appid"), (String) call.argument("channel"));
                initConfig.setAutoStart(true);
                initConfig.setAbEnable((Boolean) call.argument("enable_ab"));
                AppLog.setEncryptAndCompress((Boolean) call.argument("enable_encrypt"));
                if ((Boolean) call.argument("enable_log")) {
                    initConfig.setLogger(new ILogger() {
                        @Override
                        public void log(String s, Throwable throwable) {
                            Log.d("AppLog------->: ", "" + s);
                        }
                    });
                }
                if ((String) call.argument("host") != null) {
                    initConfig.setUriConfig(UriConfig.createByDomain((String) call.argument("host"), null));
                }
                AppLog.init(activity.getApplicationContext(), initConfig);
                break;
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
