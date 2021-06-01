package com.bytedance.rangers_applog_flutter_plugin_example;

import android.os.Bundle;

import com.bytedance.applog.AppLog;
import com.bytedance.applog.InitConfig;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

//    InitConfig initConfig = new InitConfig("159486", "local_test");
//    initConfig.setAutoStart(true);
//    initConfig.setAbEnable(true);
//    initConfig.setLogger((s, throwable) -> android.util.Log.d("AppLog", s, throwable));
//    AppLog.init(this, initConfig);
  }
}
