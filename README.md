# RangersAppLogFlutterPlugin

*For global version, please check `global` branch.*

 RangersAppLog的[Flutter插件](https://pub.dev/packages/rangers_applog_flutter_plugin)。支持埋点上报。
 
 Flutter plugin for RangersAppLog.
 
 提示：可以到[Rangers官网](https://datarangers.com.cn/)查看更详细的文档 
 
 Note: Refer to more detailed docs at https://datarangers.com/
 
##  集成 Install plugin

### Add dependency in `pubspec.yaml` 
```
dependencies:
    rangers_applog_flutter_plugin: ^1.1.0
```
 
### Install plugin
```
 flutter packages get  
```

### iOS
#### Podfile
Add source commands in `Podfile`
```ruby
source 'https://cdn.cocoapods.org'
source 'https://github.com/bytedance/cocoapods_sdk_source_repo.git'
source 'https://github.com/volcengine/volcengine-specs.git'
```
Add RangersAppLog dependency. 具体可参考Example或[iOS集成文档](https://datarangers.com.cn/datarangers/help/doc?lid=1097&did=8547)
```ruby
  pod 'RangersAppLog', '~> 6.3.2', :subspecs => ['Core', 'Log', 'Host/CN']  # 中国区上报
  # pod 'RangersAppLog', '~> 5.6.3', :subspecs => ['Core', 'Log', 'Host/SG']  # report to SG
```

#### 初始化 Init SDK
You can init SDK in native side or dart side.

1. Natvie side
在原生`- [AppDeleate (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions]`中初始化。
初始化方式请参考Example或[iOS集成文档](https://datarangers.com.cn/datarangers/help/doc?lid=1097&did=8547)

Take a look at project example project [AppDelegate.m](example/ios/Runner/AppDelegate.m).

2. dart side.
```dart
RangersApplogFlutterPlugin.initRangersAppLog('123456','test_channel', true, true, false, null);
```
#### 注册插件 Register plugin
```objective-c
#import "GeneratedPluginRegistrant.h"
#import <rangers_applog_flutter_plugin/RangersApplogFlutterPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [RangersApplogFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"RangersApplogFlutterPlugin"]];
}

@end
```

### Android
#### 初始化 Init SDK
You can init SDK in native side or dart side.
1. Init SDK in native side. 在android原生工程集成依赖并初始化RangersAppLog，请参考[RangersAppLog Android](https://datarangers.com.cn/datarangers/help/doc?lid=1097&did=10942)
2. Init SDK in dart side.
  
### Flutter
import plugin
```dart
import 'package: rangers_applog_flutter_plugin/rangers_applog_flutter_plugin.dart';
```

### Usage example
 ```dart
 RangersApplogFlutterPlugin.onEventV3("test_event_name", {"event_param":"param_value"});
 ```

其他更多接口请参考Demo和plugin注释。
For more detailed docs and usage examples, please refer to source code doc and example project in this repo.
