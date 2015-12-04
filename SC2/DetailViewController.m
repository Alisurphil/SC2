//
//  DetailViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/26.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()
- (IBAction)collect:(UIBarButtonItem *)sender;
@property(strong,nonatomic)NSString *item;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"_listName=%@",_listName);
    _item=_listName[@"cellTitle"];
    PFQuery *detailview=[PFQuery queryWithClassName:@"HomeDetails"];
    [detailview whereKey:@"cellTitle" equalTo:_item];
    [detailview findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for ( PFObject *object in objects ) {
                PFFile *imgFile=(PFFile *)[object objectForKey:@"cellImage"];
                NSString *imgUrl = imgFile.url;
                _detailImg.contentMode = UIViewContentModeScaleAspectFill;
                _detailImg.clipsToBounds = YES;
                [_detailImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
                _textView.text=object[@"cellContent"];

            }
                    }
    }];
    NSLog(@"detailview=%@",detailview);
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




#pragma mark - Navigation



- (IBAction)collect:(UIBarButtonItem *)sender {
    
    [Utilities popUpAlertViewWithMsg:@"收藏成功" andTitle:nil];
    
    
}


@end
