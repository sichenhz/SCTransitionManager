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
 *  进行放大展开的UIView对象，此对象应该是sourceViewController的子View
 */
@property (nonatomic, weak) UIView *sourceView;

/**
 *  起始ViewController
 */
@property (nonatomic, weak) UIViewController *sourceVC;

/**
 *  动画结束时，sourceView对象的frame，注意：坐标系基于sourceVC.view
 */
@property (nonatomic, assign) CGRect targetFrame;


@end
