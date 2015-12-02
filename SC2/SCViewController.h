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
@interface SCViewController : UITabBarController<UITabBarControllerDelegate>

@property (strong, nonatomic) LoginViewController *loginVC;

@property (strong,nonatomic) UINavigationController *FirstNC;
@property (strong,nonatomic) FirstViewController *FirstVC;

@property (strong,nonatomic) UINavigationController *SecondNC;
@property (strong,nonatomic) SecondCollectionViewController *SecondVC;

@property (strong,nonatomic) UINavigationController *ThirdNC;
@property (strong,nonatomic) ThirdTableViewController *ThirdVC;

@end
