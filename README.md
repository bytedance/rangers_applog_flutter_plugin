# RangersAppLogFlutterPlugin

 RangersAppLog的[Flutter插件](https://pub.dev/packages/rangers_applog_flutter_plugin)。支持埋点上报。
 
##  集成

### 在项目中添加安装插件
pubspec.yaml 中添加依赖
 
 ```
 dependencies:
 	rangers_applog_flutter_plugin: ^0.0.1
 ```
 
 执行 flutter packages get 命令安装插件
 ```
 flutter packages get  
```

### iOS 端
 
依赖RangersAppLog并初始化SDK。
 
 ```
source 'https://github.com/CocoaPods/Specs.git'

target 'YourTarget' do
  pod 'RangersAppLog', '4.0.0'
end
 ```
初始化方式请参考[RangersAppLog](https://github.com/bytedance/RangersAppLog)
 
检查是否有注册`RangersApplogFlutterPlugin`的代码
 
```
#import "GeneratedPluginRegistrant.h"
#import <rangers_applog_flutter_plugin/RangersApplogFlutterPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {

	/// 
  [RangersApplogFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"RangersApplogFlutterPlugin"]];
}

@end
```

### Android 端

尚未支持，待后续更新。
  
### Flutter 中使用插件 
import插件

```
import 'package: rangers_applog_flutter_plugin/rangers_applog_flutter_plugin.dart';
```

使用Flutter plugin上报

 ```
 RangersApplogFlutterPlugin.eventV3("appid", "test_event", {"key":"value"});
 ```

其他更多接口请参考Demo和plugin注释。

