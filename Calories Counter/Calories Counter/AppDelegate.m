#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)(void))completionHandler
{
    UNAuthorizationOptions option =UNAuthorizationOptionSound+UNAuthorizationOptionAlert;
    completionHandler();
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
  UNUserNotificationCenter  *center =[UNUserNotificationCenter currentNotificationCenter];
    //center.delegate=self;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
 
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
