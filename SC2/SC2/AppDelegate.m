//
//  AppDelegate.m
//  SC2
//
//  Created by wx on 15/11/24.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "AppDelegate.h"
#import "SCViewController.h"
#import "ECSlidingViewController.h"
#import "LeftViewController.h"
@interface AppDelegate ()<UIViewControllerAnimatedTransitioning, ECSlidingViewControllerDelegate, ECSlidingViewControllerLayout>

@property (strong,nonatomic) ECSlidingViewController *slidingViewController;
//关于滑动操作类型的整型枚举（common点进去看）
@property (assign, nonatomic) ECSlidingViewControllerOperation operation;
@end

@implementation AppDelegate

-(void)initializeRootView{
    //根据名称center找到对应的页面实例
    UINavigationController *SC = [Utilities getStoryboardInstanceByIdentity:@"SC"];
    //初始化ECSlidingViewController对象，将center对象设置为门框的中间门板（ECSlidingViewController对象的中间页面）
    _slidingViewController = [[ECSlidingViewController alloc]initWithTopViewController:SC];
    //注册协议
    _slidingViewController.delegate = self;
    //设置滑动动画执行时间
    _slidingViewController.defaultTransitionDuration = 0.25;
    //设置中间视图能对哪些配置好的手势响应（tapping以及panning）
    _slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    //将上述已选配的手势加到需要的页面上
    [SC.view addGestureRecognizer:self.slidingViewController.panGesture];
    LeftViewController *lvc = [Utilities getStoryboardInstanceByIdentity:@"Left"];
    //设置_slidingViewController的左侧页面（门框的左门板）
    _slidingViewController.underLeftViewController = lvc;
    //设置中间页面向右滑动后，留在屏幕上的宽度
    _slidingViewController.anchorRightPeekAmount = UI_SCREEN_W / 4;
    //注册名为LeftSwitch的通知，该通知回触发leftSwitchAction方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftSwitchAction) name:@"LeftSwitch" object:nil];
    //注册两个通知观察者执行同意滑动与不同意滑动
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableSwitchAction) name:@"EnableSwitch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableSwitchAction) name:@"DisableSwitch" object:nil];
}
//处理侧滑行为的方法
-(void)leftSwitchAction{
    NSLog(@"侧滑");
    //判断中间页面当前所处的位置，如果当前位置为已展开（被滑倒右侧），则需要出发关门操作；反之（未展开），则执行开门操作
    if (_slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        [_slidingViewController resetTopViewAnimated:YES];
    } else {
        [_slidingViewController anchorTopViewToRightAnimated:YES];
    }
}
//同意滑动
-(void)enableSwitchAction{
    NSLog(@"可滑");
    _slidingViewController.panGesture.enabled = YES;
}
//不同意滑动
-(void)disableSwitchAction{
    NSLog(@"不可滑");
    _slidingViewController.panGesture.enabled = NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse setApplicationId:@"7tSVXFxpH5iTVYQcl5jBE3GeiLtGIcvAUlNo21RB" clientKey:@"gwd6RddU5QQkQv88MiI0WLuV7e78FybRr4eIBb73"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    //初始化主窗口并将主窗口设置为屏幕大小
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //将该窗口设置为keywindow
    [self.window makeKeyAndVisible];
    //获得main。story实例
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //在main.story中找到名为tab的页面
    SCViewController *SCVC = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:SCVC];
    //将上述页面设置为app入口
    self.window.rootViewController = navi;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "self.SC2" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SC2" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SC2.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
