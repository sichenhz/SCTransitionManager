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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor grayColor];
        vc.title = @"third VC";
        [self.navigationController pushViewController:vc animated:YES];
    });
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
