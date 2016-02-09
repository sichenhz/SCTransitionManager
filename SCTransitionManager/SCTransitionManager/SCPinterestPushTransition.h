//
//  SCPinterestPushTransition.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/9.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPinterestPushTransition : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  动画时长.
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *  动画结束时，view对象的frame，注意：坐标系基于sourceViewController.view
 */
@property (nonatomic, assign) CGRect targetFrame;

/**
 *  进行放大展开的UIView对象，此对象应该是sourceViewController的子View
 */
@property (nonatomic, weak) UIView *sourceView;

/**
 *  起始ViewController
 */
@property (nonatomic,weak) UIViewController *sourceViewController;

@end
