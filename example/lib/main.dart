import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:rangers_applog_flutter_plugin/rangers_applog_flutter_plugin.dart';

void main() => runApp(MyApp());

const String RangersAppLogTestAppID = '159486';
const String RangersAppLogTestChannel = 'local_test';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer _timer;
  String _sdkVersion = 'Unknown';
  String _did = 'Unknown';
  String _iid = 'Unknown';
  String _ssid = 'Unknown';
  String _uuid = 'Unknown';
  String _abValue = 'Unknown';

  String _device_id = 'Unknown';
  String _ab_sdk_version = 'Unknown';
  String _ab_config_value = 'Unknown';

  final TextEditingController _appid_controller = new TextEditingController();
  final TextEditingController _channel_controller = new TextEditingController();
  final TextEditingController _enable_log_controller =
      new TextEditingController();
  final TextEditingController _enable_ab_controller =
      new TextEditingController();
  final TextEditingController _report_url_controller =
      new TextEditingController();

  Future<void> _getDid() async {
    String value = 'Unknown';
    try {
      final String result = await RangersApplogFlutterPlugin.getDeviceId();
      value = result;
    } on Exception {}
    setState(() {
      _did = value;
    });
  }

  // Future<void> _getIid() async {
  //   String value  = 'Unknown';
  //   try {
  //     final String result = await RangersApplogFlutterPlugin.byteDanceInstallID(RangersAppLogTestAppID);
  //     value = result;
  //   } on Exception {
  //   }
  //   setState(() {
  //     _iid = value;
  //   });
  // }

  // Future<void> _getSSID() async {
  //   String value  = 'Unknown';
  //   try {
  //     final String result = await RangersApplogFlutterPlugin.byteDanceSSID(RangersAppLogTestAppID);
  //     value = result;
  //   } on Exception {
  //   }
  //   setState(() {
  //     _ssid = value;
  //   });
  // }

  // Future<void> _getUUID() async {
  //   String value  = 'Unknown';
  //   try {
  //     final String result = await RangersApplogFlutterPlugin.userUniqueID(RangersAppLogTestAppID);
  //     value = result;
  //   } on Exception {
  //   }
  //   setState(() {
  //     _uuid = value;
  //   });
  // }

  // Future<void> _getABTestValue() async {
  //   String value  = 'Unknown';
  //   try {
  //     final String result = await RangersApplogFlutterPlugin.abTestValue(RangersAppLogTestAppID,"experiment-no2");
  //     value = result;
  //   } on Exception {
  //   }
  //   setState(() {
  //     _abValue = value;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    initSDKState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  Future<void> initSDKState() async {
    String value;
    try {
      RangersApplogFlutterPlugin.initRangersAppLog(
          RangersAppLogTestAppID, "dp_tob_sdk_test2");
      // value = await RangersApplogFlutterPlugin.sdkVersion;
    } on PlatformException {
      value = 'Failed to get sdk version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _timer = new Timer(const Duration(milliseconds: 400), () {
      // _getUUID();
      _getDid();
      // _getSSID();
      // _getIid();
      // _getABTestValue();
    });

    setState(() {
      _sdkVersion = value;
    });
  }

  Future<void> _getDeviceID() async {
    String value = 'Unknown';
    try {
      final String result = await RangersApplogFlutterPlugin.getDeviceId();
      value = result;
    } on Exception {}
    setState(() {
      _device_id = value;
    });
  }

  Future<void> _getAbSdkVersion() async {
    String value = 'Unknown';
    try {
      final String result = await RangersApplogFlutterPlugin.getAbSdkVersion();
      value = result;
    } on Exception {}
    setState(() {
      _ab_sdk_version = value;
    });
  }

  Future<void> _getABTestConfigValueForKey() async {
    String value = 'Unknown';
    try {
      final String result =
          await RangersApplogFlutterPlugin.getABTestConfigValueForKey(
              'ab_config_key');
      value = result;
    } on Exception {}
    setState(() {
      _ab_config_value = value;
    });
  }

  static int uuid = 2020;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ListView(
            children: <Widget>[
              new TextField(
                controller: _appid_controller,
                decoration: new InputDecoration(
                  hintText: 'please input appid',
                ),
              ),
              new TextField(
                controller: _channel_controller,
                decoration: new InputDecoration(
                  hintText: 'please input channel',
                ),
              ),
              new TextField(
                controller: _enable_log_controller,
                decoration: new InputDecoration(
                  hintText: 'please input 1 to enable or 0 to disable log',
                ),
              ),
              new TextField(
                controller: _enable_ab_controller,
                decoration: new InputDecoration(
                  hintText: 'please input 1 to enable or 0 to disable ab',
                ),
              ),
              new TextField(
                controller: _report_url_controller,
                decoration: new InputDecoration(
                  hintText: 'please input report url if need to custom',
                ),
              ),
              ListTile(
                  title: Text("Test init rangers applog"),
                  onTap: () {
                    try {
                      RangersApplogFlutterPlugin.enableDebugLog =
                          int.parse(_enable_log_controller.text) > 0
                              ? true
                              : false;
                    } on FormatException {}
                    try {
                      RangersApplogFlutterPlugin.enableAb =
                          int.parse(_enable_ab_controller.text) > 0
                              ? true
                              : false;
                    } on FormatException {}
                    RangersApplogFlutterPlugin.reportUrl =
                        _report_url_controller.text;
                    String appIdText = _appid_controller.text;
                    String channelText = _channel_controller.text;
                    String appid = appIdText != null && appIdText.isNotEmpty
                        ? appIdText
                        : RangersAppLogTestAppID;
                    String channel =
                        channelText != null && channelText.isNotEmpty
                            ? channelText
                            : RangersAppLogTestChannel;
                    RangersApplogFlutterPlugin.initRangersAppLog(
                        appid, channel);
                  }),
              ListTile(
                  title: Text("Test get device_id $_device_id"),
                  onTap: () {
                    _getDeviceID();
                  }),
              ListTile(
                  title: Text("Test get ab_sdk_version $_ab_sdk_version"),
                  onTap: () {
                    _getAbSdkVersion();
                  }),
              ListTile(
                  title: Text("Test get abTestConfigValue $_ab_config_value"),
                  onTap: () {
                    _getABTestConfigValueForKey();
                  }),
              ListTile(
                  title: Text("Test onEventV3"),
                  onTap: () {
                    RangersApplogFlutterPlugin.onEventV3(
                        "event_v3_name", {"key1": "value1", "key2": "value2"});
                  }),
              ListTile(
                  title: Text("Test setHeaderInfo"),
                  onTap: () {
                    RangersApplogFlutterPlugin.setHeaderInfo({
                      "header_key1": "header_value1",
                      "header_key2": "header_value2",
                      // "header_key3": Null  // Invalid argument: Null
                    });
                  }),
              ListTile(
                  title: Text("Test setUserUniqueId"),
                  onTap: () {
                    RangersApplogFlutterPlugin.setUserUniqueId(uuid.toString());
                    uuid++;
                  }),
              ListTile(title: Text("RangersApplog SDK Version $_sdkVersion")),
              ListTile(
                  title: Text("Test start Track "),
                  onTap: () {
                    // RangersApplogFlutterPlugin.startTrack(RangersAppLogTestAppID, "dp_tob_sdk_test2");
                  }),
              ListTile(
                  title: Text("Test call did $_did "),
                  onTap: () {
                    _getDid();
                  }),
              // ListTile(
              //     title: Text("Test call ssid $_ssid "),
              //     onTap: () {
              //       _getSSID();
              //     }),
              // ListTile(
              //     title: Text("Test call iid $_iid "),
              //     onTap: () {
              //       _getIid();
              //     }),
              // ListTile(
              //     title: Text("Test call uuid $_uuid "),
              //     onTap: () {
              //       _getUUID();
              //     }),
              ListTile(
                  title: Text("Test call eventV3 "),
                  onTap: () {
                    RangersApplogFlutterPlugin.onEventV3(
                        "test_event", {"key": "value"});
                  }),
              // ListTile(
              //     title: Text("Test call abTestValue $_abValue "),
              //     onTap: () {
              //       _getABTestValue();
              //     }),
            ],
          )),
    );
  }
}
