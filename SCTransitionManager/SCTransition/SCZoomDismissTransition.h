//
//  SCZoomDismissTransition.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/9.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGestureTransitionBackContext.h"

@interface SCZoomDismissTransition : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  动画开始时，进行缩小的UIView对象
 */
@property (nonatomic, weak) UIView *sourceView;

/**
 *  动画结束时，已经缩小的UIView对象
 */
@property (nonatomic,weak) UIView *targetView;

/**
 *  起始View，即ViewController.view
 */
@property (nonatomic, weak) UIView *view;

/**
 *  目标view，即ViewController.view
 */
@property (nonatomic, weak) UIView *destinationView;

@property (nonatomic,strong) SCGestureTransitionBackContext *context;

@end
