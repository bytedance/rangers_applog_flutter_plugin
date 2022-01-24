## 1.3.0
* iOS & Android: add support of the following method(s):
  * receiveABTestConfigStream
  * receiveABVidsChangeStream

## 1.2.2
* iOS: Compatible with "use framwork!"

## 1.2.1
* Update doc

## 1.2.0
* Migrate to Android V2 embedding

## 1.1.0
* Migrate to null safety

## 1.0.6
* Update doc

## 1.0.5
* iOS & Android: add support of the following method(s):
  * removeHeaderInfo

## 1.0.4

* iOS & Android: add support of the following methods:
  * initRangersAppLog (please take a look at the interface doc)
  * profileSet
  * profileSetOnce
  * profileUnset
  * profileIncrement
  * profileAppend
* iOS: add support of the following methods:
  * getAllAbTestConfig

## 1.0.3

* Android: 插件改为compileOnly依赖原生RangersAppLog，需要在原生android工程implementation依赖。
* Android: 插件移除初始化接口，需要在原生android工程初始化RangersAppLog。
* iOS：插件本身不依赖 RangersAppLog。需要在ios工程中依赖。
* iOS：插件不提供初始化接口。需要在原生`- [AppDeleate (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions]`中初始化。

## 1.0.2

* 支持android

## 1.0.1

* 修改iOS SDK依赖版本号

## 1.0.0

**废弃版本号**

* 增加日志上报接口
* 增加获取基本属性接口