//
//  LoginViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/25.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

- (IBAction)signIn:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    if (![[Utilities getUserDefaults:@"userName"] isKindOfClass:[NSNull class]]) {
        _usernameTF.text = [Utilities getUserDefaults:@"userName"];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([[[storageMgr singletonStorageMgr] objectForKey:@"signUp"] integerValue] == 1) {
        [[storageMgr singletonStorageMgr] removeObjectForKey:@"signUp"];
        [self popUpHomeTab];
    }

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



- (IBAction)signIn:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *username = _usernameTF.text;
    NSString *password = _passwordTF.text;
    
    if ([username isEqualToString:@""] || [password isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil];
        return;
    }
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        [aiv stopAnimating];
        if (user) {
            [Utilities setUserDefaults:@"userName" content:username];
            _passwordTF.text = @"";
            [self popUpHomeTab];
        } else if (error.code == 101) {
            [Utilities popUpAlertViewWithMsg:@"用户名或密码错误" andTitle:nil];
        } else if (error.code == 100) {
            [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试" andTitle:nil];
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];

}
@end
