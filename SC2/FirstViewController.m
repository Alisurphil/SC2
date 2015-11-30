//
//  FirstViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/25.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataPreparation];
    [self uiConfiguration];
    CGRect rect = _headerView.frame;
    rect.size.height = self.view.frame.size.width / 2;
    _headerView.frame = rect;
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, rect.size.height - 40, rect.size.width, 40)];
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
    
    CGFloat imageW = self.view.frame.size.width;
    CGFloat imageH = rect.size.height;
    CGFloat imageY = 0;
    NSInteger totalCount = 5;
    for (int i = 0; i < totalCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        imageView.clipsToBounds = YES;
        //设置图片
        NSString *name = [NSString stringWithFormat:@"shouye%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self.scrollView addSubview:imageView];
    }
    CGFloat contentW = totalCount *imageW;
    self.scrollView.contentSize = CGSizeMake(contentW, rect.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self addTimer];
}
- (void)dataPreparation {
    _objectsForShow = nil;
    _objectsForShow = [NSMutableArray new];
    _aiv = [Utilities getCoverOnView:[[UIApplication sharedApplication] keyWindow]];
    [self initializeData];
}
//下拉刷新：刷新器+初始数据（第一页数据）
- (void)initializeData {
    loadCount = 1;
    perPage = 3;
    loadingMore = NO;
    [self urlAction];
}
-(void)urlAction{
    [_aiv stopAnimating];
    [self loadDataEnd];
    UIRefreshControl *refreshControl=[self.tableView viewWithTag:8001];
    
    //将上述下拉刷新控件停止刷新
    [refreshControl endRefreshing];
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
    [refreshControl addTarget:self action:@selector(initializeData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
-(void)refreshData:(UIRefreshControl *)sender{
    //假装话了2秒请求数据并更新tableView
    [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [self addTimer];
//}

- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

- (void)removeTimer{
    [self.timer invalidate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentSize.height > scrollView.frame.size.height) {
        if (!loadingMore && scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) {
            [self loadDataBegin];
        }
    } else {
        if (!loadingMore && scrollView.contentOffset.y > 0) {
            [self loadDataBegin];
        }
    }
}

- (void)loadDataBegin {
    if (loadingMore == NO) {
        loadingMore = YES;
        [self createTableFooter];
        _tableFooterAI = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((UI_SCREEN_W - 86.0f) / 2 - 30.0f, 10.0f, 20.0f, 20.0f)];
        [_tableFooterAI setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [self.tableView.tableFooterView addSubview:_tableFooterAI];
        [_tableFooterAI startAnimating];
        [self loadDataing];
    }
}

- (void)loadDataing {
    if (totalPage > loadCount) {
        loadCount ++;
        [self urlAction];
    } else {
        [self performSelector:@selector(beforeLoadEnd) withObject:nil afterDelay:0.25];
    }
}

- (void)beforeLoadEnd {
    UILabel *label = (UILabel *)[self.tableView.tableFooterView viewWithTag:9001];
    [label setText:@"当前已无更多数据"];
    [_tableFooterAI stopAnimating];
    _tableFooterAI = nil;
    [self performSelector:@selector(loadDataEnd) withObject:nil afterDelay:0.25];
}

- (void)loadDataEnd {
    self.tableView.tableFooterView = [[UIView alloc] init];
    loadingMore = NO;
}

- (void)createTableFooter {
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 40.0f)];
    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_W - 86.0f) / 2, 0.0f, 116.0f, 40.0f)];
    loadMoreText.tag = 9001;
    [loadMoreText setFont:[UIFont systemFontOfSize:B_Font]];
    [loadMoreText setText:@"上拉显示更多数据"];
    [tableFooterView addSubview:loadMoreText];
    loadMoreText.textColor = [UIColor grayColor];
    self.tableView.tableFooterView = tableFooterView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
