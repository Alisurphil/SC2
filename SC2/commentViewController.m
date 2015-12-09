//
//  commentViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/27.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "commentViewController.h"
#import "commentTableViewCell.h"
@interface commentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inPutcommt;
- (IBAction)sendCommt:(UIButton *)sender forEvent:(UIEvent *)event;
@property (strong,nonatomic) NSArray *userArray;
@property(strong,nonatomic)NSString *status;

@end

@implementation commentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TAOverlayOptions options = TAOverlayOptionNone;
    _status = nil;
    _status = @"加载中";
    [TAOverlay showOverlayWithLabel:_status Options:(options | TAOverlayOptionOverlaySizeRoundedRect | TAOverlayOptionOverlayTypeActivityBlur)];
    // Do any additional setup after loading the view.
    //PFUser *collectUser = [PFUser currentUser];
    PFQuery *comment = [PFQuery queryWithClassName:@"Comment"];
    [comment includeKey:@"commentUser"];
    [comment whereKey:@"commentTitle" equalTo:_nextName];
    [comment orderByDescending:@"updatedAt"];
    [comment findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            _allComment = nil;
            _allComment = [NSArray new];
            _allComment = objects;
            NSLog(@"allComment=%@",_allComment);
            [_tableView reloadData];
        }
          }];
    [TAOverlay hideOverlay];
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
    return _allComment.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    commentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell3" forIndexPath:indexPath];
    PFObject *object = [_allComment objectAtIndex:indexPath.row];
    PFObject *pace = object[@"commentUser"];
    cell.theName.text = pace[@"username"];
    cell.theDetail.text = object[@"commentDetails"];
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

- (IBAction)sendCommt:(UIButton *)sender forEvent:(UIEvent *)event {
    TAOverlayOptions options = TAOverlayOptionNone;
    _status = nil;
    _status = @"评论中";
    [TAOverlay showOverlayWithLabel:_status Options:(options | TAOverlayOptionOverlaySizeRoundedRect | TAOverlayOptionOverlayTypeActivityBlur)];
    PFUser *collectUser = [PFUser currentUser];
    PFObject *fil = [PFObject objectWithClassName:@"Comment"];
    fil[@"commentUser"] = collectUser;
    fil[@"commentDetails"] = _inPutcommt.text;
    fil[@"commentTitle"] = _nextName;
    [fil saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [Utilities popUpAlertViewWithMsg:@"评论成功！" andTitle:nil];
            [_tableView reloadData];
        }
        [TAOverlay hideOverlay];
    }];
    
}
@end
