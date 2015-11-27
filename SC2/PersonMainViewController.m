//
//  PersonMainViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/27.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "PersonMainViewController.h"

@interface PersonMainViewController ()
- (IBAction)finishChange:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *changeNikName;
@property (weak, nonatomic) IBOutlet UITextField *setYearOld;
@property (weak, nonatomic) IBOutlet UITextField *Locail;
@property (weak, nonatomic) IBOutlet UITextField *faVourite;

@end

@implementation PersonMainViewController

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

- (IBAction)finishChange:(UIBarButtonItem *)sender {
}
@end
