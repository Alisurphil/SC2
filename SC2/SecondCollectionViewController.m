//
//  SecondCollectionViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/12/2.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "SecondCollectionViewController.h"
#import "SecondCollectionViewCell.h"
@interface SecondCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) NSMutableArray *heightArr;
@property (strong,nonatomic) NSMutableArray *objectsForShow;
@end

@implementation SecondCollectionViewController
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    if (self.navigationController.tabBarItem.tag == 0) {
        self.navigationItem.title = @"首页";
    } else if (self.navigationController.tabBarItem.tag == 1) {
        self.navigationItem.title = @"图片";
    } else if (self.navigationController.tabBarItem.tag == 2) {
        self.navigationItem.title = @"聊天";
    } else if (self.navigationController.tabBarItem.tag == 3) {
        self.navigationItem.title = @"好友列表";
    } else if (self.navigationController.tabBarItem.tag == 4) {
        self.navigationItem.title = @"我";
    }
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"SecondCell"];
    
    _heightArr = [NSMutableArray new];
    _objectsForShow = [NSMutableArray new];
    for (int i = 0; i < 100; i ++) {
        for (int j = 1; j < 13; j ++) {
            NSString *girlFilename = [NSString stringWithFormat:@"pubu%lu.jpg", (unsigned long)j];
            UIImage *image = [UIImage imageNamed:girlFilename];
            [_objectsForShow addObject:image];
        }
    }
    [self.collectionView reloadData];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _objectsForShow.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *myCell=[collectionView dequeueReusableCellWithReuseIdentifier:
                                  @"SecondCell" forIndexPath:indexPath];
    [myCell setBackgroundColor:[UIColor redColor]];
    
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width / 2 - 3;
    NSInteger remainder=indexPath.row%2;
    NSInteger currentRow=indexPath.row/2;
    CGFloat   currentHeight=[self.heightArr[indexPath.row] floatValue];
    
    CGFloat positonX=itemWidth*remainder+2*(remainder+1);
    CGFloat positionY=(currentRow+1)*2;
    for (NSInteger i=0; i<currentRow; i++) {
        NSInteger position=remainder+i*2;
        positionY+=[self.heightArr[position] floatValue];
    }
    myCell.frame = CGRectMake(positonX, positionY,itemWidth,currentHeight) ;
    
    UIImage *image = [_objectsForShow objectAtIndex:indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    [myCell setBackgroundView:imageView];
    return  myCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = [_objectsForShow objectAtIndex:indexPath.row];
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width / 2 - 3;
    //    NSLog(@"itemHeight = %f", itemWidth / image.size.width * image.size.height);
    CGFloat itemHeight = itemWidth / image.size.width * image.size.height;
    [self.heightArr addObject:[NSString stringWithFormat:@"%f",itemHeight]];
    return CGSizeMake(itemWidth, itemHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"enablePanGes" object:nil];
}
//每当离开该页面以后调用以下方法（进入其他视图页面以后）
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"disablePanGes" object:nil];
}
#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
