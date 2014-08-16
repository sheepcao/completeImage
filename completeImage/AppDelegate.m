//
//  AppDelegate.m
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [ShareSDK registerApp:@"2a5d674d9a31"];
    [ShareSDK connectWeChatWithAppId:@"wx4e1ffebe5397b9ef" wechatCls:[WXApi class]];
//    [ShareSDK  connectSinaWeiboWithAppKey:@"2794760105"
//                                appSecret:@"31dbf958ccc3fa37f6e99cf0ec643c5e"
//                              redirectUri:@"https://www.weibo.com/"
//                              weiboSDKCls:[WeiboSDK class]];
    [ShareSDK connectSinaWeiboWithAppKey:@"2794760105"
                               appSecret:@"31dbf958ccc3fa37f6e99cf0ec643c5e"
                             redirectUri:@"https://www.weibo.com/"];

    

    
    [ShareSDK connectQQWithAppId:@"1102040569" qqApiCls:[QQApi class]];
    [ShareSDK connectQZoneWithAppKey:@"1102040569"
                           appSecret:@"Mwz2RaYqfPrB2wit"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    
    [ShareSDK connectFacebookWithAppKey:@"746495262075375"
                              appSecret:@"7f7416a1a6d46dee6999dca7d242e566"];
    
    
    
    // Override point for customization after application launch.
    scores = [[NSMutableArray alloc] initWithCapacity:bigLevel];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:@"scores"]) {
        [scores setArray: [ud objectForKey:@"scores"]];
    }else
    {
        for (int i = 0; i<bigLevel; i++) {
            [scores insertObject:[NSNumber numberWithInt:0] atIndex:i];
        }
    }
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleDefault];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    levelTop = levelTop<level?level:levelTop;
    
    levelSaved =[NSNumber numberWithInt:levelTop];
    haveSharedString = [NSString stringWithFormat:@"%d",[haveShared[0] intValue]];
   
    //增减大关卡时，修改循环次数
    for (int i = 1; i<6; i++) {
       haveSharedString = [haveSharedString stringByAppendingString:[NSString stringWithFormat:@",%d",[haveShared[i] intValue]]];
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:levelSaved forKey:@"saveLevel"];
    [ud setObject:scores forKey:@"scores"];
    [ud setObject:haveSharedString forKey:@"saveShareState"];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    

    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    levelTop = levelTop<level?level:levelTop;
    
    levelSaved =[NSNumber numberWithInt:levelTop];
    haveSharedString = [NSString stringWithFormat:@"%d",[haveShared[0] intValue]];
    //增减大关卡时，修改循环次数
    for (int i = 1; i<6; i++) {
        haveSharedString = [haveSharedString stringByAppendingString:[NSString stringWithFormat:@",%d",[haveShared[i] intValue]]];
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:levelSaved forKey:@"saveLevel"];
    [ud setObject:scores forKey:@"scores"];
    [ud setObject:haveSharedString forKey:@"saveShareState"];
    scores = nil;

}

@end
