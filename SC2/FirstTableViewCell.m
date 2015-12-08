//
//  FirstTableViewCell.m
//  SC2
//
//  Created by wx on 15/11/30.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)likeButton:(UIButton *)sender {
    [_delegate addlike:_indexPath];
    
}

- (IBAction)unlikeButton:(UIButton *)sender {
    [_delegate addunlike:_indexPath];
}
@end
