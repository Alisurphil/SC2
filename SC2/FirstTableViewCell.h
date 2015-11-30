//
//  FirstTableViewCell.h
//  SC2
//
//  Created by wx on 15/11/30.
//  Copyright © 2015年 wx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *unlikeLabel;
- (IBAction)likeButton:(UIButton *)sender;
- (IBAction)unlikeButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
