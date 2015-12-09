//
//  commentTableViewCell.h
//  SC2
//
//  Created by 姚国俊 on 15/12/9.
//  Copyright © 2015年 wx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *theName;
@property (weak, nonatomic) IBOutlet UILabel *theDetail;

@end
