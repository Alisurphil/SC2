//
//  DetailViewController.h
//  SC2
//
//  Created by 袁文轶 on 15/11/26.
//  Copyright © 2015年 wx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property(strong,nonatomic)PFObject *listName;
@property (weak, nonatomic) IBOutlet UIImageView *detailImg;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
