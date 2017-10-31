//
//  AppDelegate.m
//  Examples
//
//  Created by 宋永建 on 2017/9/2.
//  Copyright © 2017年 Global. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *rootVC = [[ViewController alloc]init];
    self.window.rootViewController =  [[UINavigationController alloc]
                                       initWithRootViewController:rootVC];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
