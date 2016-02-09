//
//  SCDismissTransition.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/7.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGestureTransitionBackContext.h"

@interface SCDismissTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) SCGestureTransitionBackContext *context;

@end
