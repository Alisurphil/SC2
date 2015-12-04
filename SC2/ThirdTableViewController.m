//
//  ThirdTableViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/12/1.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "ThirdTableViewController.h"
@interface ThirdTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIView *headView;
- (IBAction)useImag:(UIButton *)sender forEvent:(UIEvent *)event;


@end

@implementation ThirdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController.tabBarItem.tag == 0) {
        self.navigationItem.title = @"首页";
    } else if(self.navigationController.tabBarItem.tag == 1){
        self.navigationItem.title = @"聊天";
    }else {
        self.navigationItem.title = @"我";
    }
    
    
    PFUser *user = [PFUser currentUser];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        _nickName.text = user[@"nickName"];
        _sexy.text = user[@"gender"];
        _address.text = user[@"address"];
        _usually.text = user[@"race"];
    _age.text = [dateFormatter stringFromDate:user[@"birthDate"]];
    
}
-(void)viewWillAppear:(BOOL)animated{
    if (![[Utilities getUserDefaults:@"userName"] isKindOfClass:[NSNull class]]) {
        if (![[Utilities getUserDefaults:@"userName"] isKindOfClass:[NSNull class]]) {
            NSString *currentStr = [Utilities getUserDefaults:@"userName"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDirectory = [directories objectAtIndex:0];
            __block NSString *filePath = nil;
            filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", currentStr]];
            if ([fileManager fileExistsAtPath:filePath]) {
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                [_useImage setBackgroundImage:image forState:UIControlStateNormal];
            } else {
                [_useImage setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
            }
        }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)useImag:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
