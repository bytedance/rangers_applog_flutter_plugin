import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:rangers_applog_flutter_plugin/rangers_applog_flutter_plugin.dart';

void main() => runApp(MyApp());

const String RangersAppLogTestAppID = '159486';

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

  Future<void> _getDid() async {
    String value  = 'Unknown';
    try {
      final String result = await RangersApplogFlutterPlugin.byteDanceDeviceID(RangersAppLogTestAppID);
      value = result;
    } on Exception {
    }
    setState(() {
      _did = value;
    });
  }

  Future<void> _getIid() async {
    String value  = 'Unknown';
    try {
      final String result = await RangersApplogFlutterPlugin.byteDanceInstallID(RangersAppLogTestAppID);
      value = result;
    } on Exception {
    }
    setState(() {
      _iid = value;
    });
  }

  Future<void> _getSSID() async {
    String value  = 'Unknown';
    try {
      final String result = await RangersApplogFlutterPlugin.byteDanceSSID(RangersAppLogTestAppID);
      value = result;
    } on Exception {
    }
    setState(() {
      _ssid = value;
    });
  }

  Future<void> _getUUID() async {
    String value  = 'Unknown';
    try {
      final String result = await RangersApplogFlutterPlugin.userUniqueID(RangersAppLogTestAppID);
      value = result;
    } on Exception {
    }
    setState(() {
      _uuid = value;
    });
  }

  Future<void> _getABTestValue() async {
    String value  = 'Unknown';
    try {
      final String result = await RangersApplogFlutterPlugin.abTestValue(RangersAppLogTestAppID,"experiment-no2");
      value = result;
    } on Exception {
    }
    setState(() {
      _abValue = value;
    });
  }

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
      RangersApplogFlutterPlugin.startTrack(RangersAppLogTestAppID, "dp_tob_sdk_test2");
      value = await RangersApplogFlutterPlugin.sdkVersion;
    } on PlatformException {
      value = 'Failed to get sdk version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _timer = new Timer(const Duration(milliseconds: 400), () {
      _getUUID();
      _getDid();
      _getSSID();
      _getIid();
      _getABTestValue();
    });

    setState(() {
      _sdkVersion = value;
    });
  }

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
                  title: Text("RangersApplog SDK Version $_sdkVersion")
              ),
              ListTile(
                  title: Text("Test start Track "),
                  onTap: () {
                    RangersApplogFlutterPlugin.startTrack(RangersAppLogTestAppID, "dp_tob_sdk_test2");
                  }),
              ListTile(
                  title: Text("Test call did $_did "),
                  onTap: () {
                     _getDid();
                  }),
              ListTile(
                  title: Text("Test call ssid $_ssid "),
                  onTap: () {
                    _getSSID();
                  }),
              ListTile(
                  title: Text("Test call iid $_iid "),
                  onTap: () {
                    _getIid();
                  }),
              ListTile(
                  title: Text("Test call uuid $_uuid "),
                  onTap: () {
                    _getUUID();
                  }),
              ListTile(
                  title: Text("Test login "),
                  onTap: () {
                    RangersApplogFlutterPlugin.login(RangersAppLogTestAppID, "1234");
                  }),
              ListTile(
                  title: Text("Test logout "),
                  onTap: () {
                    RangersApplogFlutterPlugin.logout(RangersAppLogTestAppID);
                  }),
              ListTile(
                  title: Text("Test call eventV3 "),
                  onTap: () {
                    RangersApplogFlutterPlugin.eventV3(RangersAppLogTestAppID, "test_event", {"key":"value"});
                  }),
              ListTile(
                  title: Text("Test call abTestValue $_abValue "),
                  onTap: () {
                    _getABTestValue();
                  }),
              ListTile(
                  title: Text("Test set ABSDKVersion "),
                  onTap: () {
                    RangersApplogFlutterPlugin.abSDKVersion(RangersAppLogTestAppID, "10086");
                  }),
              ListTile(
                  title: Text("Test active user "),
                  onTap: () {
                    RangersApplogFlutterPlugin.activeUser(RangersAppLogTestAppID);
                  }),
            ],
          )
      ),
    );
  }
}
