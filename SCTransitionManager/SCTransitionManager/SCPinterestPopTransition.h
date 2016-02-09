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
 *  动画时长.
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 * @param sourceView 进行缩小的UIView对象
 */
@property (nonatomic,strong) UIView *sourceView;
/**
 *  动画结束时，目标View
 *
 *  @param destinationView
 */
@property (nonatomic,weak) UIView *destinationView;
/**
 *  动画结束时，view对象的frame，注意：坐标系基于sourceViewController.view
 */
@property (nonatomic, assign) CGRect targetFrame;
/**
 *  起始的ViewController
 *
 *  @param sourceViewController
 */
@property (nonatomic,weak) UIViewController *sourceViewController;

/**
 * 设置将要展示的ViewController，即目标VC
 * @param destinationViewController
 */
@property (nonatomic, weak) UIViewController *destinationViewController;

@property (nonatomic,strong) SCGestureTransitionBackContext *context;

@end
