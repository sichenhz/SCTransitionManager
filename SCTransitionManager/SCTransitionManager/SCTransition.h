//
//  SCTransition.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/7.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTransition : NSObject<UIViewControllerTransitioningDelegate>

/**
 *  @param view 要支持手势返回的view
 */
- (instancetype)initWithView:(UIView *)view;

@end
