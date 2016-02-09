//
//  SCTransitionManager.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/5.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTransitionManager : NSObject<UIViewControllerTransitioningDelegate>

- (instancetype)initWithSwipeBackView:(UIView *)swipeBackView;

- (instancetype)initWithSwipeBackView:(UIView *)swipeBackView
                           sourceView:(UIView *)sourceView
                             sourceVC:(UIViewController *)sourceVC
                           targetView:(UIView *)targetView
                             targetVC:(UIViewController *)targetVC
                          targetFrame:(CGRect)targetFrame
                           completion:(void (^)())completion;

@end
