//
//  PersonTableViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/30.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "PersonTableViewController.h"

@interface PersonTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tablView;
- (IBAction)backToMe:(UIBarButtonItem *)sender;
- (IBAction)finishChange:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *changeNikName;
@property (weak, nonatomic) IBOutlet UITextField *changeSex;
@property (weak, nonatomic) IBOutlet UITextField *changeOld;
@property (weak, nonatomic) IBOutlet UITextField *changeLocation;
@property (weak, nonatomic) IBOutlet UITextField *changeFavourite;


@end

@implementation PersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToMe:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finishChange:(UIBarButtonItem *)sender {
}
@end
