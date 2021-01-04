# RangersAppLogFlutterPlugin

 RangersAppLog的[Flutter插件](https://pub.dev/packages/rangers_applog_flutter_plugin)。支持埋点上报。
 
##  集成

### 在项目中添加安装插件
在`pubspec.yaml` 中添加依赖
```
dependencies:
    rangers_applog_flutter_plugin: ^1.0.3
```
 
执行 `flutter packages get` 命令安装插件
```
 flutter packages get  
```

### iOS 端
#### Podfile
如果`pod install`失败，在`Podfile`中添加下面的code
```
source 'https://github.com/bytedance/cocoapods_sdk_source_repo.git'
```
初始化方式请参考[RangersAppLog](https://github.com/bytedance/RangersAppLog)
 
#### 注册插件
```objective-c
#import "GeneratedPluginRegistrant.h"
#import <rangers_applog_flutter_plugin/RangersApplogFlutterPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [RangersApplogFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"RangersApplogFlutterPlugin"]];
}

@end
```

### Android 端
需要在android原生工程集成依赖并初始化RangersAppLog，请参考[RangersAppLog Android](https://datarangers.com.cn/datarangers/help/doc?lid=1097&did=10942)

  
### Flutter 中使用插件 
import插件

```
import 'package: rangers_applog_flutter_plugin/rangers_applog_flutter_plugin.dart';
```

使用Flutter plugin上报

 ```
 RangersApplogFlutterPlugin.onEventV3("appid", "test_event", {"key":"value"});
 ```

其他更多接口请参考Demo和plugin注释。

