//
//  AppDelegate.h
//  SC2
//
//  Created by wx on 15/11/24.
//  Copyright © 2015年 wx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SCViewController.h"
#import "ApplyViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,IChatManagerDelegate>  {
    EMConnectionState _connectionState;
}


@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) SCViewController *mainController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

