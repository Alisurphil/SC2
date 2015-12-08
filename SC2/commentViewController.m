//
//  commentViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/27.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "commentViewController.h"

@interface commentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inPutcommt;
- (IBAction)sendCommt:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation commentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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

- (IBAction)sendCommt:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
