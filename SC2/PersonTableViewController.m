//
//  PersonTableViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/30.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "PersonTableViewController.h"
#import "ThirdTableViewController.h"

@interface PersonTableViewController ()

- (IBAction)backToMe:(UIBarButtonItem *)sender;
- (IBAction)finishChange:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *changeNikName;
@property (weak, nonatomic) IBOutlet UITextField *changeSex;
@property (weak, nonatomic) IBOutlet UITextField *changeLocation;
@property (weak, nonatomic) IBOutlet UITextField *changeFavourite;
@property (weak, nonatomic) IBOutlet UITableViewCell *birthday;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIView *coverView;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) NSDate *selected;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation PersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _coverView = nil;
    _coverView = [[UIView alloc] initWithFrame:self.tableView.frame];
    _coverView.hidden = YES;
    _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:_coverView];
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 180, self.view.frame.size.width, 180)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = [UIColor whiteColor];
    [_coverView addSubview:self.datePicker];
    //[self.datePicker addTarget:self action:@selector(datePicker:) forControlEvents:UIControlEventValueChanged];
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, _datePicker.frame.origin.y - 46, self.view.frame.size.width, 46)];
    self.toolBar.barStyle = UIBarStyleDefault;
    self.toolBar.translucent = YES;
    UIBarButtonItem *flixSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flixSpace.width = 15;
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtn:)];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtn:)];
    UIBarButtonItem *flexSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.toolBar setItems:@[flixSpace, cancelBtn, flexSpace, doneBtn, flixSpace] animated:YES];
    [_coverView addSubview:self.toolBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToMe:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        _coverView.hidden = NO;
    }
}

- (void)cancelBtn:(id)sender {
    _coverView.hidden = YES;
}

- (void)doneBtn:(id)sender {
    _coverView.hidden = YES;
    _selected = [_datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _dateLabel.text = [dateFormatter stringFromDate:_selected];
    
    

}
//昵称：nickName性别：gender年龄：age地址：address种族：race




- (IBAction)finishChange:(UIBarButtonItem *)sender {
    PFUser *user = [PFUser currentUser];
    if (_changeNikName.text.length > 0) {
        user[@"nickName"] = _changeNikName.text;
    }
    if (_changeSex.text.length > 0) {
        user[@"gender"] = _changeSex.text;
    }
    if (_changeLocation.text.length > 0) {
        user[@"address"] = _changeLocation.text;
    }
    if (_changeFavourite.text.length > 0) {
        user[@"race"] = _changeFavourite.text;
    }
    if (_dateLabel.text.length > 0) {
        user[@"birthDate"] = _selected;
    }
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"OK");
        } else {
            NSLog(@"error = %@", error.description);
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
