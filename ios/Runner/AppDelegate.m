#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
@import Firebase;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // TODO: Configurationによって参照するファイル名を切り替え
//    NSString* path = [[NSBundle mainBundle] pathForResource: @"GoogleService-Info2" ofType: @"plist"];
//    FIROptions* options = [[FIROptions alloc] initWithContentsOfFile: path];
//    [FIRApp configureWithOptions: options];
//    NSLog(@"projectID: %@", FIRApp.defaultApp.options.projectID);

    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end

