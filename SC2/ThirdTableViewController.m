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
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    if (self.navigationController.tabBarItem.tag == 0) {
        self.navigationItem.title = @"首页";
    } else if(self.navigationController.tabBarItem.tag == 1){
        self.navigationItem.title = @"聊天";
    }else {
        self.navigationItem.title = @"我";
    }
    
    
    
    
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
    PFUser *user = [PFUser currentUser];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _nickName.text = user[@"nickName"];
    if ([user[@"gender"]  isEqual: @"nan"]) {
        _sexy.text = @"男";
    }else if ([user[@"gender"]  isEqual: @"nv"]){
        _sexy.text = @"女";
    }else{
        _sexy.text = @"";
    }
    _address.text = user[@"address"];
    _usually.text = user[@"race"];
    _age.text = [dateFormatter stringFromDate:user[@"birthDate"]];
    _tblView.tableFooterView = [[UIView alloc]init];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"enablePanGes" object:nil];
}
//每当离开该页面以后调用以下方法（进入其他视图页面以后）
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"disablePanGes" object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)useImag:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
