//
//  SCTransitionManager.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/5.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTransitionManager : NSObject<UIViewControllerTransitioningDelegate,
UINavigationControllerDelegate>

- (instancetype)initWithView:(UIView *)view
                      isPush:(BOOL)isPush;

- (instancetype)initWithView:(UIView *)view
                  sourceView:(UIView *)sourceView
                  targetView:(UIView *)targetView
                      isPush:(BOOL)isPush;

@end
