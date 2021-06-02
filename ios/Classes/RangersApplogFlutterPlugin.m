//
//  RangersAppLogFlutterPlugin.m
//  RangersAppLogFlutterPlugin
//
//  Created by bob on 2019/9/27.
//

#import "RangersApplogFlutterPlugin.h"
#import <RangersAppLog/RangersAppLog.h>


static inline id setNSNullToNil(id value, Class target){
    if (value == NSNull.null) {
        return nil;
    }
    if (![value isKindOfClass:target]) {
        return nil;
    }
    return value;
}

@interface RangersApplogFlutterPlugin ()

@end


@implementation RangersApplogFlutterPlugin

// 在应用didFinishLaunching时被调用
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"rangers_applog_flutter_plugin"
                                                                binaryMessenger:[registrar messenger]];

    RangersApplogFlutterPlugin* instance = [RangersApplogFlutterPlugin new];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *methodName = call.method;
    NSDictionary *arguments = setNSNullToNil(call.arguments, [NSDictionary class]);
    
    if ([methodName isEqualToString:@"sdkVersion"]) {
        result([BDAutoTrack sdkVersion]);
    }
    else if ([methodName isEqualToString:@"initRangersAppLog"]) {
        NSString *appID = setNSNullToNil([arguments valueForKey:@"appid"], [NSString class]);
        NSString *channel = setNSNullToNil([arguments valueForKey:@"channel"], [NSString class]);
        NSNumber *enableAB = setNSNullToNil([arguments valueForKey:@"enable_ab"], [NSNumber class]);
        NSNumber *enableEncrypt = setNSNullToNil([arguments valueForKey:@"enable_encrypt"], [NSNumber class]);
        NSNumber *enableDebugLog = setNSNullToNil([arguments valueForKey:@"enable_log"], [NSNumber class]);
        NSString *host = setNSNullToNil([arguments valueForKey:@"host"], [NSString class]);
        
        BDAutoTrackConfig *config = [BDAutoTrackConfig configWithAppID:appID];
        if ([channel isKindOfClass:NSString.class] && channel.length > 0) {
            config.channel = channel;
        }
        config.logNeedEncrypt = [enableEncrypt boolValue];
        config.abEnable = [enableAB boolValue];
        config.showDebugLog = [enableDebugLog boolValue];
        config.serviceVendor = BDAutoTrackServiceVendorCN;
#if DEBUG
        config.showDebugLog = YES;
        config.logger = ^(NSString * log) {
            NSLog(@"flutter-plugin applog %@",log);
        };
#endif
        if ([host isKindOfClass:NSString.class] && host.length > 0) {
            [BDAutoTrack setRequestHostBlock:^NSString * _Nullable(BDAutoTrackServiceVendor vendor, BDAutoTrackRequestURLType requestURLType) {
                return host;
            }];
        }
        [BDAutoTrack startTrackWithConfig:config];
        result(nil);
    }
    else if ([methodName isEqualToString:@"onEventV3"]) {
        // NSLog(@"%@", call.arguments);
        NSString *event = setNSNullToNil([arguments valueForKey:@"event"], [NSString class]);
        NSDictionary *param = [arguments valueForKey:@"param"];
        BOOL ret = [BDAutoTrack eventV3:event params:param];
        result(nil);
    }
    else if ([methodName isEqualToString:@"getDeviceId"]) {
        result([BDAutoTrack rangersDeviceID]);
    }

    /* Custom Header */
    else if ([methodName isEqualToString:@"setHeaderInfo"]) {
        NSDictionary *customHeader = setNSNullToNil([arguments valueForKey:@"customHeader"], [NSDictionary class]);
        for (NSString *key in customHeader) {
            if ([key isKindOfClass:NSString.class]) {
                NSObject *val = customHeader[key];
                [BDAutoTrack setCustomHeaderValue:val forKey:key];
            }
        }
    }

    /* Login and Logout */
    else if ([methodName isEqualToString:@"setUserUniqueId"]) {
        NSString *userUniqueID = setNSNullToNil([arguments valueForKey:@"uuid"], [NSString class]);
        [BDAutoTrack setCurrentUserUniqueID:userUniqueID];
    }
    
    /* AB Test */
    else if ([methodName isEqualToString:@"getAbSdkVersion"]) {
        NSString *vids = [BDAutoTrack allAbVids];
        result(vids);
    }
    else if ([methodName isEqualToString:@"getAllAbTestConfig"]) {
        NSDictionary *allConfigs = [[BDAutoTrack sharedTrack] allABTestConfigs];
        result(allConfigs);
    }
    else if ([methodName isEqualToString:@"getABTestConfigValueForKey"]) {
        NSString *key = setNSNullToNil([arguments valueForKey:@"key"], [NSString class]);
        NSObject *defaultVal = setNSNullToNil([arguments valueForKey:@"default"], [NSObject class]);
        id val = [BDAutoTrack ABTestConfigValueForKey:key defaultValue:defaultVal];
        result(val);
    }
    
    /* Profile */
    else if ([methodName isEqualToString:@"profileSet"]) {
        NSDictionary *profileDict = setNSNullToNil([arguments valueForKey:@"profileDict"], [NSDictionary class]);
        [[BDAutoTrack sharedTrack] profileSet:profileDict];
    }
    else if ([methodName isEqualToString:@"profileSetOnce"]) {
        NSDictionary *profileDict = setNSNullToNil([arguments valueForKey:@"profileDict"], [NSDictionary class]);
        [[BDAutoTrack sharedTrack] profileSetOnce:profileDict];
    }
    else if ([methodName isEqualToString:@"profileUnset"]) {
        NSString *key = setNSNullToNil([arguments valueForKey:@"key"], [NSString class]);
        [[BDAutoTrack sharedTrack] profileUnset:key];
    }
    else if ([methodName isEqualToString:@"profileIncrement"]) {
        NSDictionary *profileDict = setNSNullToNil([arguments valueForKey:@"profileDict"], [NSDictionary class]);
        [[BDAutoTrack sharedTrack] profileIncrement:profileDict];
    }
    else if ([methodName isEqualToString:@"profileAppend"]) {
        NSDictionary *profileDict = setNSNullToNil([arguments valueForKey:@"profileDict"], [NSDictionary class]);
        [[BDAutoTrack sharedTrack] profileAppend:profileDict];
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

@end
