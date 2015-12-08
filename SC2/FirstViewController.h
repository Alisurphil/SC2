//
//  FirstViewController.h
//  SC2
//
//  Created by 袁文轶 on 15/11/25.
//  Copyright © 2015年 wx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTableViewCell.h"
@interface FirstViewController : UIViewController<FirstTableViewCellDelegate>{
    BOOL loadingMore;
    NSInteger loadCount;
    NSInteger perPage;
    NSInteger totalPage;
}
@property (strong, nonatomic) NSArray *objectsForShow;

@property (strong, nonatomic) UIActivityIndicatorView *tableFooterAI;

@end
