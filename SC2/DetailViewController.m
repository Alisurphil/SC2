//
//  DetailViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/26.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (IBAction)collect:(UIBarButtonItem *)sender;




@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSLog(@"_listName=%@",_listName);
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

- (IBAction)collect:(UIBarButtonItem *)sender {
    
}

//- (IBAction)backTOMain:(UIBarButtonItem *)sender {
//    [Utilities getStoryboardInstanceByIdentity:@"First"];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end
