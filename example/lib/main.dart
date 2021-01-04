import 'package:flutter/material.dart';
import 'dart:async';

import 'package:rangers_applog_flutter_plugin/rangers_applog_flutter_plugin.dart';

void main() => runApp(MyApp());

const String RangersAppLogTestAppID = '159486';
const String RangersAppLogTestChannel = 'local_test';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _sdkVersion = 'Unknown';
  String _did = 'Unknown';

  String _device_id = 'Unknown';
  String _ab_sdk_version = 'Unknown';
  String _ab_config_value = 'Unknown';

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
      final String result = await RangersApplogFlutterPlugin.getABTestConfigValueForKey('ab_config_key', "");
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
