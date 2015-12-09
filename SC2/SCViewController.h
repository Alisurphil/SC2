//
//  SCViewController.h
//  SC2
//
//  Created by 袁文轶 on 15/11/25.
//  Copyright © 2015年 wx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import "SecondCollectionViewController.h"
#import "ThirdTableViewController.h"
#import "LoginViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ChatListViewController.h"
#import "ContactsViewController.h"
#import "ChatViewController.h"
#import "EMCDDeviceManager.h"
#import "ApplyViewController.h"
#import "UserProfileManager.h"
#import "CallViewController.h"
#import "TTGlobalUICommon.h"
#import "InvitationManager.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

@interface SCViewController : UITabBarController <UITabBarControllerDelegate> {
    EMConnectionState _connectionState;
    ChatListViewController *_chatListVC;
    ContactsViewController *_contactsVC;
    UIBarButtonItem *_addFriendItem;

}

@property (strong, nonatomic) LoginViewController *loginVC;

@property (strong,nonatomic) UINavigationController *FirstNC;
@property (strong,nonatomic) FirstViewController *FirstVC;


@property (strong,nonatomic) SecondCollectionViewController *SecondVC;

@property (strong,nonatomic) UINavigationController *ThirdNC;
@property (strong,nonatomic) ThirdTableViewController *ThirdVC;

@property (strong,nonatomic) UINavigationController *SecondNCA;
@property (strong,nonatomic) UINavigationController *SecondNCB;
@property (strong,nonatomic) UINavigationController *SecondNCC;

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

- (void)networkChanged:(EMConnectionState)connectionState;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;


@end
