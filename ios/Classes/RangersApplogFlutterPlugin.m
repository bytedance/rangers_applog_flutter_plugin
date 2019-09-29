//
//  RangersAppLogFlutterPlugin.m
//  RangersAppLogFlutterPlugin
//
//  Created by bob on 2019/9/27.
//

#import "RangersApplogFlutterPlugin.h"
#import <RangersAppLog/BDAutoTrack.h>

static NSString * const FlutterPluginMethodStartTrack           = @"startTrack";
static NSString * const FlutterPluginMethodSDKVersion           = @"sdkVersion";
static NSString * const FlutterPluginMethodDeviceID             = @"byteDanceDeviceID";
static NSString * const FlutterPluginMethodInstallID            = @"byteDanceInstallID";
static NSString * const FlutterPluginMethodSSID                 = @"byteDanceSSID";
static NSString * const FlutterPluginMethodUUID                 = @"userUniqueID";

static NSString * const FlutterPluginMethodLogin                = @"login";
static NSString * const FlutterPluginMethodLogout               = @"logout";
static NSString * const FlutterPluginMethodEventV3              = @"eventV3";
static NSString * const FlutterPluginMethodABTestValue          = @"abTestValue";

static NSString * const FlutterPluginMethodABSDKVersion         = @"abSDKVersion";
static NSString * const FlutterPluginMethodActiveUser           = @"activeUser";
static NSString * const FlutterPluginMethodTrackUIEvent         = @"trackUIEvent";

static inline id applog_fliterNSNull(id value, Class target){
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

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"rangers_applog_flutter_plugin"
                                                                binaryMessenger:[registrar messenger]];

    RangersApplogFlutterPlugin* instance = [RangersApplogFlutterPlugin new];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *method = call.method;
    if ([method isEqualToString:FlutterPluginMethodSDKVersion]) {
        result([BDAutoTrack sdkVersion]);
        return;
    }

    NSArray *arguments = applog_fliterNSNull(call.arguments, [NSArray class]);
    NSString *appID = applog_fliterNSNull(arguments.firstObject, [NSString class]);
    if ([appID length] < 1 || arguments.count < 1) {
        result(nil);
        return;
    }

    if ([method isEqualToString:FlutterPluginMethodStartTrack]) {
        [self startTrackWithAppID:appID arguments:arguments];
        result(nil);
        return;
    }

    BDAutoTrack *track = [BDAutoTrack trackWithAppID:appID];
    if (!track) {
        result(nil);
        return;
    }

    if ([method isEqualToString:FlutterPluginMethodDeviceID]) {
        result(track.byteDanceDeviceID);
        return;
    }

    if ([method isEqualToString:FlutterPluginMethodInstallID]) {
        result(track.installID);
        return;
    }

    if ([method isEqualToString:FlutterPluginMethodSSID]) {
        result(track.ssID);
        return;
    }

    if ([method isEqualToString:FlutterPluginMethodUUID]) {
        result(track.userUniqueID);
        return;
    }

    if ([method isEqualToString:FlutterPluginMethodLogout]) {
        [track clearUserUniqueID];
        result(nil);
        return;
    }

    if ([method isEqualToString:FlutterPluginMethodLogin]) {
        NSString *uuid = applog_fliterNSNull([arguments objectAtIndex:1], [NSString class]);
        [track setCurrentUserUniqueID:uuid];
        result(nil);
        return;
    }

    /// TODO diff UIEvent
    if ([method isEqualToString:FlutterPluginMethodEventV3]
        || [method isEqualToString:FlutterPluginMethodTrackUIEvent]) {
        NSString *event = applog_fliterNSNull([arguments objectAtIndex:1], [NSString class]);
        NSDictionary *param = applog_fliterNSNull([arguments objectAtIndex:2], [NSDictionary class]);
        [track eventV3:event params:param];
        result(nil);
        return;
    }

    if ([method isEqualToString:FlutterPluginMethodABSDKVersion]) {
        NSString *abSDKVersion = applog_fliterNSNull([arguments objectAtIndex:1], [NSString class]);
        [track setABSDKVersions:abSDKVersion];
        result(nil);
        return;
    }

    if ([method isEqualToString:FlutterPluginMethodABTestValue]) {
        NSString *key = applog_fliterNSNull([arguments objectAtIndex:1], [NSString class]);
        id value = [track ABTestConfigValueForKey:key defaultValue:nil];
        result(value);
        return;
    }

    if ([method isEqualToString:FlutterPluginMethodActiveUser]) {
        [track activeUser];
        result(nil);
        return;
    }
}

- (void)startTrackWithAppID:(NSString *)appID arguments:(NSArray *)arguments {
    BDAutoTrackConfig *config = [BDAutoTrackConfig new];
    config.appID = appID;
    config.appName = applog_fliterNSNull([arguments objectAtIndex:1], [NSString class]);
    config.channel = applog_fliterNSNull([arguments objectAtIndex:2], [NSString class]);
    NSString *vendor = applog_fliterNSNull([arguments objectAtIndex:3], [NSString class]);
    BDAutoTrackServiceVendor serviceVendor =  BDAutoTrackServiceVendorCN;
    if ([vendor isEqualToString:@"SG"]) {
        serviceVendor =  BDAutoTrackServiceVendorSG;
    } else if ([vendor isEqualToString:@"VA"]) {
        serviceVendor =  BDAutoTrackServiceVendorVA;
    }
    config.serviceVendor = serviceVendor;
    #if DEBUG
    config.showDebugLog = YES;
    config.logger = ^(NSString * log) {
        NSLog(@"flutter-plugin applog %@",log);
    };
    #endif
    BDAutoTrack *track = [BDAutoTrack trackWithConfig:config];


    [track startTrack];
}

@end
