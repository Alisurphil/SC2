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
                [_textView setFont:[UIFont systemFontOfSize:
                                    S_Font]];
                _textView.text=object[@"cellContent"];

            }
                    }
    }];
    NSLog(@"detailview=%@",detailview);
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)collect:(UIBarButtonItem *)sender {
    
}

//- (IBAction)backTOMain:(UIBarButtonItem *)sender {
//    [Utilities getStoryboardInstanceByIdentity:@"First"];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end
