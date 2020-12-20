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

@interface RangersApplogFlutterPlugin () {
    BDAutoTrack *track;
}

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
        NSNumber *enableAB = setNSNullToNil([arguments valueForKey:@"enableAb"], [NSNumber class]);
        NSNumber *enableDebugLog = setNSNullToNil([arguments valueForKey:@"enableLog"], [NSNumber class]);
        NSString *reportUrl = setNSNullToNil([arguments valueForKey:@"reportUrl"], [NSString class]);
        
        BDAutoTrackConfig *config = [BDAutoTrackConfig configWithAppID:appID];
        if ([channel isKindOfClass:NSString.class] && channel.length > 0) {
            config.channel = channel;
        }
        config.abEnable = [enableAB boolValue];
        config.showDebugLog = [enableDebugLog boolValue];
        config.serviceVendor = BDAutoTrackServiceVendorCN;
#if DEBUG
        config.showDebugLog = YES;
        config.logger = ^(NSString * log) {
            NSLog(@"flutter-plugin applog %@",log);
        };
#endif
        track = [BDAutoTrack trackWithConfig:config];
        if ([reportUrl isKindOfClass:NSString.class] && reportUrl.length > 0) {
            [track setRequestHostBlock:^NSString * _Nullable(BDAutoTrackServiceVendor vendor, BDAutoTrackRequestURLType requestURLType) {
                return reportUrl;
            }];
        }
        [track startTrack];
        result(nil);
    }
    else if ([methodName isEqualToString:@"onEventV3"]) {
        NSLog(@"%@", call.arguments);
        NSString *event = setNSNullToNil([arguments valueForKey:@"event"], [NSString class]);
        NSDictionary *param = [arguments valueForKey:@"param"];
        BOOL ret = [track eventV3:event params:param];
        result(nil);
    }
    else if ([methodName isEqualToString:@"setHeaderInfo"]) {
        NSDictionary *customHeader = setNSNullToNil([arguments valueForKey:@"customHeader"], [NSDictionary class]);
        for (NSString *key in customHeader) {
            if ([key isKindOfClass:NSString.class]) {
                NSObject *val = customHeader[key];
                [track setCustomHeaderValue:val forKey:key];
            }
        }
    }
    else if ([methodName isEqualToString:@"setUserUniqueId"]) {
        NSString *userUniqueID = setNSNullToNil([arguments valueForKey:@"uuid"], [NSString class]);
        [track setCurrentUserUniqueID:userUniqueID];
    }
    else if ([methodName isEqualToString:@"getDeviceId"]) {
        result(track.rangersDeviceID);
    }
    else if ([methodName isEqualToString:@"getAbSdkVersion"]) {
        NSString *vids = [track allAbVids];
        result(vids);
    }
    else if ([methodName isEqualToString:@"getABTestConfigValueForKey"]) {
        NSString *key = setNSNullToNil([arguments valueForKey:@"key"], [NSString class]);
        id val = [track ABTestConfigValueForKey:key defaultValue:nil];
        result(val);
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

@end
