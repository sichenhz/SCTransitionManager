//
//  SCViewController.m
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/8.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCViewController.h"
#import "SCSwipeBackInteractionController.h"

@interface SCViewController()<SCGestureBackInteractionDelegate>

@end

@implementation SCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.jpg"]];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    imageView.frame = CGRectMake(0, 64, width, width);
    [self.view addSubview:imageView];
    _avatarView = imageView;
}

#pragma mark - SCGestureBackInteractionDelegate

- (BOOL)disableGuesture {
    return NO;
}

- (void)gestureBackBegin {
    NSLog(@"手势开始");
}

- (void)gestureBackCancel {
    NSLog(@"手势取消");
}

- (void)gestureBackFinish {
    NSLog(@"手势结束");
}

//- (void)fireGuestureBack {
//    
//}

@end
