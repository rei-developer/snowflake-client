#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

// Add this line
#import <flutter_image_gallery_saver/FlutterImageGallerySaverPlugin.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
  // Add this line
  [FlutterImageGallerySaverPlugin registerWithRegistrar:[self.flutterEngine registrarForPlugin:@"FlutterImageGallerySaverPlugin"]];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
