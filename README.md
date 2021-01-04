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
在`Podfile`第一行添加
```
source 'https://github.com/bytedance/cocoapods_sdk_source_repo.git'
```
并依赖RangersAppLog. 具体可参考Example或[iOS集成文档](https://datarangers.com.cn/datarangers/help/doc?lid=1097&did=8547)

#### 初始化
需要在原生`- [AppDeleate (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions]`中初始化。
初始化方式请参考Example或[iOS集成文档](https://datarangers.com.cn/datarangers/help/doc?lid=1097&did=8547)
 
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

