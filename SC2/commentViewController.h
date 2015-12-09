//
//  commentViewController.h
//  SC2
//
//  Created by 袁文轶 on 15/11/27.
//  Copyright © 2015年 wx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) PFObject *nextName;
@property (strong,nonatomic) NSArray *allComment;
@end
