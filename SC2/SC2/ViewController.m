//
//  ViewController.m
//  SC2
//
//  Created by wx on 15/11/24.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    PFObject *annou = [PFObject objectWithClassName:@"announcement"];
//    annou[@"name"] = @"测试";
//    annou[@"content"] = @"测试测试测试";
//    [annou saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSLog(@"成功");
//        }
//    }];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == '测试'"];
    PFQuery *query = [PFQuery queryWithClassName:@"announcement" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        PFObject *annou = objects.firstObject;
//        NSLog(@"%@", annou[@"content"]);
//        annou[@"content"] = @"不测试不测试";
//        [annou saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//            NSLog(@"成功");
//        }];
        [annou deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"成功");
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
