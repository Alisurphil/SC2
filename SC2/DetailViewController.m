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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *collect;
@property(strong,nonatomic)NSString *item;

@property(strong,nonatomic)NSString *name;
@property(nonatomic)NSInteger i;
@property(strong,nonatomic)PFObject *obj;

@property(strong,nonatomic)NSString *status;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    TAOverlayOptions options = TAOverlayOptionNone;
    _status = nil;
    _status = @"加载中";
    [TAOverlay showOverlayWithLabel:_status Options:(options | TAOverlayOptionOverlaySizeRoundedRect | TAOverlayOptionOverlayTypeActivityBlur)];
    [super viewDidLoad];
    PFUser *collectUser=[PFUser currentUser];
    NSLog(@"collectUser=%@",collectUser);
    //_name=collectUser[@"username"];
    PFQuery *collect=[PFQuery queryWithClassName:@"Collect"];
    [collect whereKey:@"collectToUser" equalTo:collectUser];
    [collect whereKey:@"collectToHome" equalTo:_listName];
    
    [collect countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (number==0) {
            _i=0;
            _collect.tintColor=[UIColor blueColor];
        }else{
            _i = 1;
            _collect.tintColor=[UIColor lightGrayColor];
            
        }
    }];
           [TAOverlay hideOverlay];

    NSLog(@"_listName=%@",_listName);
    PFFile *imgFile=(PFFile *)[_listName objectForKey:@"cellAllImage"];
    NSString *imgUrl = imgFile.url;
    _detailImg.contentMode = UIViewContentModeScaleAspectFill;
    _detailImg.clipsToBounds = YES;
    [_detailImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
    [_textView setFont:[UIFont systemFontOfSize:
                        S_Font]];
    _textView.text=_listName[@"cellAllContent"];
    
        }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




#pragma mark - Navigation



- (IBAction)collect:(UIBarButtonItem *)sender {
    
    if (_i==0) {
        PFObject *collect1=[PFObject objectWithClassName:@"Collect"];
        PFUser *user = [PFUser currentUser];
        collect1[@"collectToUser"]= user;
        collect1[@"collectToHome"]=_listName;
        [collect1 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                [Utilities popUpAlertViewWithMsg:@"收藏成功" andTitle:nil];
                _collect.tintColor=[UIColor lightGrayColor];
                _i = 1;
            }else{
                [Utilities popUpAlertViewWithMsg:@"收藏失败" andTitle:nil];
                NSLog(@"%@",error);
            }
        }];
        
    }else{
        PFUser *collectUser=[PFUser currentUser];
        PFQuery *collect2=[PFQuery queryWithClassName:@"Collect"];
        [collect2 whereKey:@"collectToUser" equalTo:collectUser];
        [collect2 whereKey:@"collectToHome" equalTo:_listName];
        NSLog(@"collect2=%@",collect2);
        [collect2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                _obj = objects.firstObject;
                [_obj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        [Utilities popUpAlertViewWithMsg:@"已删除收藏" andTitle:nil];
                        _collect.tintColor=[UIColor blueColor];
                        _i = 0;
                } else {
                    NSLog(@"%@",error);
                }
                 }];
            }
        }];
        
    }
}



@end
