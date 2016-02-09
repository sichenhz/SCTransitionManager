//
//  SCZoomPresentTransition.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/9.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCZoomPresentTransition : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  动画开始时，进行放大的UIView对象
 */
@property (nonatomic, weak) UIView *sourceView;

/**
 *  起始view，即ViewController.view
 */
@property (nonatomic, weak) UIView *view;

/**
 *  动画结束时，sourceView对象的frame，注意：坐标系基于view
 */
@property (nonatomic, assign) CGRect targetFrame;


@end
