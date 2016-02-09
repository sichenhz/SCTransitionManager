//
//  SCPinterestPopTransition.m
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/9.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCPinterestPopTransition.h"
#import "UIView+Capture.h"

@implementation SCPinterestPopTransition

- (instancetype)init {
    if (self = [super init]) {
        _duration = 0.3;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController* destinationViewController_ = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:destinationViewController_.view];
    [containerView sendSubviewToBack:destinationViewController_.view];

    UIView *sourceViewImageView = [_sourceView captureView];
    
    UIView *animationView = [[UIView alloc]initWithFrame:_destinationViewController.view.frame];
    animationView.backgroundColor = [UIColor clearColor];
    [_destinationViewController.view.superview insertSubview:animationView aboveSubview:_destinationViewController.view];
    [animationView addSubview:sourceViewImageView];
    
    //    UIImage *destinationViewImage = [_destinationViewController.view capture];
    //    UIView *view = _destinationViewController.view;
    UIImage *layerImage = [_destinationViewController.view captureLayer];
    UIView *destinationImageView = [[UIImageView alloc]initWithImage:layerImage];//[_destinationViewController.view captureView];
    UIView *whiteBgView = [[UIView alloc]initWithFrame:_destinationViewController.view.bounds];
    whiteBgView.backgroundColor = [UIColor whiteColor];
    [_destinationViewController.view addSubview:whiteBgView];
    
    destinationImageView.frame = whiteBgView.bounds;
    [whiteBgView addSubview:destinationImageView];
    //TODO 王海 下面3行代码最好能重构到外面
    CGRect sourceFrame_ = _sourceView.frame;
    sourceViewImageView.frame = _sourceView.frame;
    
    CGPoint centerOfDestinationView =  [_destinationView convertPoint:CGPointMake(_destinationView.frame.size.width/2, _destinationView.frame.size.height/2) toView:self.destinationViewController.view];
    //    CGPoint centerOfDestinationVCInWindow = [_destinationViewController.view convertPoint:CGPointMake(_destinationViewController.view.frame.size.width/2, _destinationViewController.view.frame.size.height/2) toView:nil];
    
    //    CGFloat deltaX = centerOfDestinationView.x-centerOfDestinationVCInWindow.x;
    //    CGFloat deltaY = centerOfDestinationView.y-centerOfDestinationVCInWindow.y;
    
    CGPoint centerOfSourceFrame = CGPointMake(sourceFrame_.origin.x+sourceFrame_.size.width/2, sourceFrame_.origin.y+sourceFrame_.size.height/2);
    //    CGPoint centerOfDestinationVC = CGPointMake(_destinationViewController.view.frame.size.width/2, _destinationViewController.view.frame.size.height/2);
    //    CGFloat distanceToTopY =  centerOfSourceFrame.y - centerOfDestinationVC.y;
    //    CGFloat distanceToTopX =  centerOfSourceFrame.x - centerOfDestinationVC.x;
    
    CGFloat deltaXToSourceFrameCenter = centerOfSourceFrame.x - centerOfDestinationView.x;
    CGFloat deltaYToSourceFrameCenter = centerOfSourceFrame.y - centerOfDestinationView.y;
    
    
    CGFloat xScale = sourceFrame_.size.width/_destinationView.frame.size.width;
    CGFloat yScale = xScale;
    CGAffineTransform trans = CGAffineTransformConcat(CGAffineTransformMakeTranslation(deltaXToSourceFrameCenter, deltaYToSourceFrameCenter), CGAffineTransformMakeScale(xScale,yScale)) ;
    
    CGRect frame = destinationImageView.layer.frame;
    destinationImageView.layer.anchorPoint = CGPointMake(centerOfSourceFrame.x/destinationImageView.frame.size.width, centerOfSourceFrame.y/destinationImageView.frame.size.height);
    destinationImageView.layer.frame = frame;
    destinationImageView.transform = trans;
    //    CGRect frame = destinationImageView.frame;
    //    destinationImageView.alpha = 0.1;
    //    frame.origin.x = frame.origin.x-deltaX*xScale + distanceToTopX;
    //    frame.origin.y = frame.origin.y-deltaY*yScale + distanceToTopY;
    //    destinationImageView.frame = frame;
    
    
    void (^animationBlock)() = ^(){
        destinationImageView.transform = CGAffineTransformIdentity;
        //        destinationImageView.frame = whiteBgView.bounds;
        destinationImageView.alpha = 1.0;
        sourceViewImageView.frame = [_destinationView convertRect:_destinationView.bounds toView:animationView];
    };
    
    void (^animationCompleteBlock)(BOOL finished) = ^(BOOL finished){
        [whiteBgView removeFromSuperview];
        [sourceViewImageView removeFromSuperview];
        [animationView removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        
    };
    
    if (transitionContext) {
        //        _sourceViewController.view.alpha = 0;
        if ([transitionContext isInteractive]&&self.context.gestureFinished) {
            //这是苹果的bug，有时候手势都介绍了才触发动画返回（正常情况是手势开始就应调用这个方法），此时animation的completion不会被调用，会导致冻屏，因此出此下策
            animationBlock();
            animationCompleteBlock(YES);
            NSLog(@"pinterest gesture finish ahead");
        }else{
            NSLog(@"pinterest pop animation");
            [UIView animateKeyframesWithDuration:self.duration
                                           delay:0.0
                                         options:UIViewKeyframeAnimationOptionLayoutSubviews|UIViewAnimationOptionOverrideInheritedOptions
                                      animations:^{
                                          
                                          
                                          [UIView addKeyframeWithRelativeStartTime:0
                                                                  relativeDuration:0.5
                                                                        animations:^{
                                                                            _sourceViewController.view.alpha = 0;
                                                                        }];
                                          [UIView addKeyframeWithRelativeStartTime:0.5
                                                                  relativeDuration:0.5
                                                                        animations:animationBlock
                                           ];
                                          
                                      } completion:animationCompleteBlock];
        }
        
    }else{
        [UIView animateWithDuration:self.duration animations:animationBlock completion:animationCompleteBlock];
    }
    
    
    return;
}
@end
