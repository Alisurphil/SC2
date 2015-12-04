//
//  FirstViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/25.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "FirstViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailViewController.h"

@interface FirstViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property(strong,nonatomic)NSArray *wallObjectsArray;
@property(nonatomic)CGRect rect;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self urlAction];
    [self titelimage];
    [self uiConfiguration];
    _rect = _headerView.frame;
    _rect.size.height = 145;
    _headerView.frame = _rect;
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _rect.size.height - 40, _rect.size.width, 40)];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.numberOfPages = 5;
    _pageControl.currentPage = 0;
    [_headerView addSubview:_pageControl];
    
    if (self.navigationController.tabBarItem.tag == 0) {
        self.navigationItem.title = @"首页";
    } else if(self.navigationController.tabBarItem.tag == 1){
        self.navigationItem.title = @"聊天";
    }else {
        self.navigationItem.title = @"我";
    }
    
}
- (void)dataPreparation {
        _aiv = [Utilities getCoverOnView:[[UIApplication sharedApplication] keyWindow]];
    [self urlAction];
    [self titelimage];
}
-(void)titelimage{
    PFQuery *query = [PFQuery queryWithClassName:@"ScrollView"];
    //2
    [query orderByDescending:@"number"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //3
        if (!error) {
            //Everything was correct, put the new objects and load the wall
            self.wallObjectsArray = nil;
            self.wallObjectsArray = [[NSArray alloc] initWithArray:objects];
            NSLog(@"wallObjectsArray=%@",self.wallObjectsArray);
            CGFloat imageW = self.view.frame.size.width;
            CGFloat contentW = self.wallObjectsArray.count *imageW;
            self.scrollView.contentSize = CGSizeMake(contentW, _rect.size.height);
            self.scrollView.pagingEnabled = YES;
            self.scrollView.delegate = self;
            
            for (int i = 0; i < _wallObjectsArray.count; i ++){
                PFObject *wallObject = [_wallObjectsArray objectAtIndex:i];
                PFFile *image = (PFFile *)[wallObject objectForKey:@"image"];
                NSString *imageUrl = image.url;
                UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(i * imageW, 0, imageW, _rect.size.height)];
                userImage.contentMode = UIViewContentModeScaleAspectFill;
                userImage.clipsToBounds = YES;
                [userImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"start"]];
                [self.scrollView addSubview:userImage];
                
            }
            
            [self addTimer];
            
        }
        else {
            //
            //            //4
            NSLog(@"error11 = %@",error);
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];

}
//下拉刷新：刷新器+初始数据（第一页数据）
//- (void)initializeData {
//    loadCount = 1;
//    perPage = 3;
//    loadingMore = NO;
//    [self urlAction];
//}


-(void)urlAction{
    PFQuery *cellquery=[PFQuery queryWithClassName:@"Homepage"];
    [cellquery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError * _Nullable error) {
        if (!error) {
            _objectsForShow = nil;
            _objectsForShow = [NSArray new];

            NSLog(@"cellquery=%@",cellquery);
            _objectsForShow=objects;
            NSLog(@"_objectsForShow=%@",_objectsForShow);
            
            [_tableView reloadData];
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
    [_aiv stopAnimating];
    UIRefreshControl *refreshControl=[self.tableView viewWithTag:8001];
    
    //将上述下拉刷新控件停止刷新
    [refreshControl endRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _objectsForShow.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    PFObject *allObject = [_objectsForShow objectAtIndex:indexPath.row];
    PFFile *imgFile=(PFFile *)[allObject objectForKey:@"cellImage"];
    NSString *imgUrl = imgFile.url;
    cell.photoView.contentMode = UIViewContentModeScaleAspectFill;
    cell.photoView.clipsToBounds = YES;
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",allObject[@"cellTitle"]];
    //NSLog(@"cell.titleLabel.text=%@",cell.titleLabel.text);
    cell.likeLabel.text=[allObject[@"cellLike"] stringValue];
    cell.unlikeLabel.text=[allObject[@"cellUnlike"] stringValue];
    cell.contentLabel.text=allObject[@"cellContent"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 136;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)uiConfiguration {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    NSString *title = [NSString stringWithFormat:@"下拉即可刷新"];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attrsDictionary = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                                      NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                      NSParagraphStyleAttributeName:style,
                                      NSForegroundColorAttributeName:[UIColor brownColor]};
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    refreshControl.attributedTitle = attributedTitle;
    refreshControl.tintColor = [UIColor brownColor];
    refreshControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    refreshControl.tag = 8001;
    [refreshControl addTarget:self action:@selector(dataPreparation) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
- (void)nextImage{
    int page = (int)self.pageControl.currentPage;
    if (page == 4) {
        page = 0;
    }else{
        page++;
    }
    CGFloat x = page * _headerView.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(x, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
       CGFloat scrollviewW = _headerView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.pageControl.currentPage = page;
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [self removeTimer];
//}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [self addTimer];
//}

- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

//- (void)removeTimer{
//    [self.timer invalidate];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (scrollView.contentSize.height > scrollView.frame.size.height) {
//        if (!loadingMore && scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) {
//            [self loadDataBegin];
//        }
//    } else {
//        if (!loadingMore && scrollView.contentOffset.y > 0) {
//            [self loadDataBegin];
//        }
//    }
}

//- (void)loadDataBegin {
//    if (loadingMore == NO) {
//        loadingMore = YES;
//        [self createTableFooter];
//        _tableFooterAI = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((UI_SCREEN_W - 86.0f) / 2 - 30.0f, 10.0f, 20.0f, 20.0f)];
//        [_tableFooterAI setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
//        [self.tableView.tableFooterView addSubview:_tableFooterAI];
//        [_tableFooterAI startAnimating];
//        [self loadDataing];
//    }
//}
//
//- (void)loadDataing {
//    if (totalPage > loadCount) {
//        loadCount ++;
//        [self urlAction];
//    } else {
//        [self performSelector:@selector(beforeLoadEnd) withObject:nil afterDelay:0.25];
//    }
//}
//
//- (void)beforeLoadEnd {
//    UILabel *label = (UILabel *)[self.tableView.tableFooterView viewWithTag:9001];
//    [label setText:@"当前已无更多数据"];
//    [_tableFooterAI stopAnimating];
//    _tableFooterAI = nil;
//    [self performSelector:@selector(loadDataEnd) withObject:nil afterDelay:0.25];
//}
//
//- (void)loadDataEnd {
//    self.tableView.tableFooterView = [[UIView alloc] init];
//    loadingMore = NO;
//}
//
//- (void)createTableFooter {
//    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 40.0f)];
//    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_W - 86.0f) / 2, 0.0f, 116.0f, 40.0f)];
//    loadMoreText.tag = 9001;
//    [loadMoreText setFont:[UIFont systemFontOfSize:B_Font]];
//    [loadMoreText setText:@"上拉显示更多数据"];
//    [tableFooterView addSubview:loadMoreText];
//    loadMoreText.textColor = [UIColor grayColor];
//    self.tableView.tableFooterView = tableFooterView;
//}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"listTodetail"]) {
    DetailViewController *object=[segue destinationViewController];
    PFObject *model=[_objectsForShow objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        NSLog(@"model=%@",model);

        object.listName=model;
            }
}


@end
