//
//  ThirdTableViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/12/1.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "ThirdTableViewController.h"
@interface ThirdTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIView *headView;
- (IBAction)useImag:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *useImage;

@end

@implementation ThirdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tblView.delegate = self;
    _tblView.dataSource = self;
    
    if (self.navigationController.tabBarItem.tag == 0) {
        self.navigationItem.title = @"首页";
    } else if(self.navigationController.tabBarItem.tag == 1){
        self.navigationItem.title = @"聊天";
    }else {
        self.navigationItem.title = @"我";
    }
    
    if (![[Utilities getUserDefaults:@"userName"] isKindOfClass:[NSNull class]]) {
        if (![[Utilities getUserDefaults:@"userName"] isKindOfClass:[NSNull class]]) {
            NSString *currentStr = [Utilities getUserDefaults:@"userName"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDirectory = [directories objectAtIndex:0];
            __block NSString *filePath = nil;
            filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", currentStr]];
            if ([fileManager fileExistsAtPath:filePath]) {
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                [_useImage setBackgroundImage:image forState:UIControlStateNormal];
            } else {
                [_useImage setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
            }
        }
}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell4"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell4"];
    }
    cell.textLabel.text = @"stupid";
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)useImag:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
