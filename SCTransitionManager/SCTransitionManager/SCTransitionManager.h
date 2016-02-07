//
//  SCTransitionManager.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/5.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTransitionManager : NSObject

+ (SCTransitionManager *)sharedInstance;

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion;

- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)())completion;

@end
