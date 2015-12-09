//
//  CollectionViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/26.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()
- (IBAction)collectionBack:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSArray *array;


@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFQuery *query=[PFQuery queryWithClassName:@"Collect"];
    [query includeKey:@"collectToHome"];
    PFUser *collectUser=[PFUser currentUser];
    [query whereKey:@"collectToUser" equalTo:collectUser];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            _array=nil;
            _array=[NSArray new];
            _array=objects;
            NSLog(@"array=%@",_array);
            [_tableView reloadData];
        }
    }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    PFObject *collect = [_array objectAtIndex:indexPath.row];
    PFObject *post = collect[@"collectToHome"];
    cell.textLabel.text = post[@"cellTitle"];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)collectionBack:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
