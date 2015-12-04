//
//  DetailViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/26.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (IBAction)collect:(UIBarButtonItem *)sender;




@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSLog(@"_listName=%@",_listName);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)collect:(UIBarButtonItem *)sender {
    
    [Utilities popUpAlertViewWithMsg:@"收藏成功" andTitle:nil];
    
    
}


@end
