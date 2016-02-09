//
//  SCPinterestPopTransition.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/9.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGestureTransitionBackContext.h"

@interface SCPinterestPopTransition : NSObject<UIViewControllerAnimatedTransitioning>

/**
 * @param sourceView 进行缩小的UIView对象
 */
@property (nonatomic, weak) UIView *sourceView;

/**
 *  起始ViewController
 */
@property (nonatomic, weak) UIViewController *sourceVC;

/**
 *  动画结束时，目标View
 */
@property (nonatomic,weak) UIView *targetView;

/**
 *  设置将要展示的ViewController，即目标VC
 */
@property (nonatomic, weak) UIViewController *targetVC;

@property (nonatomic,strong) SCGestureTransitionBackContext *context;

@end
