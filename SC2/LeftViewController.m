//
//  LeftViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/26.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()
- (IBAction)exitID:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)userImage:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    PFUser *currentUser = [PFUser currentUser];
    _userNameLabel.text = [NSString stringWithFormat:@"昵称：%@", currentUser[@"nickName"]];
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

- (IBAction)exitID:(UIButton *)sender forEvent:(UIEvent *)event {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)userImage:(UIButton *)sender forEvent:(UIEvent *)event {
    UIActionSheet *actionSheet =[[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    //在视图上展示
    [actionSheet showInView:self.view];
}
@end
