//
//  FirstTableViewCell.h
//  SC2
//
//  Created by wx on 15/11/30.
//  Copyright © 2015年 wx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FirstTableViewCellDelegate;

@interface FirstTableViewCell : UITableViewCell
@property (weak, nonatomic) id<FirstTableViewCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *unlikeLabel;
- (IBAction)likeButton:(UIButton *)sender;
- (IBAction)unlikeButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@protocol FirstTableViewCellDelegate <NSObject>
- (void)addlike:(NSIndexPath *)indexPath;
- (void)addunlike:(NSIndexPath *)indexpath;
@end
