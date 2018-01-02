#import "IonicCordovaCommon.h"
#import <Cordova/CDVPluginResult.h>

@implementation IonicCordovaCommon

- (void)getAppInfo:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = command.callbackId;

    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString* bundleName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    
    NSString* bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (bundleVersion == nil) {
      NSLog(@"CFBundleShortVersionString was nil, attempting CFBundleVersion");
      bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
      if (bundleVersion == nil) {
        NSLog(@"CFBundleVersion was also nil, giving up");
      }
    }
    [json setObject:bundleName forKey:@"bundleName"];
    [json setObject:version forKey:@"version"];
    [json setObject:bundleVersion forKey:@"bundleVersion"];
    [json setObject:"ios" forKey:@"platform"];

    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:json] callbackId:command.callbackId];

}

@end