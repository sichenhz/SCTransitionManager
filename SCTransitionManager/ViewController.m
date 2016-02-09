//
//  ViewController.m
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/5.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "ViewController.h"
#import "SCTransitionManager.h"
#import "SCViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"main VC";
}

- (IBAction)present:(id)sender {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = @"Second VC";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor greenColor];
    [[SCTransitionManager sharedInstance] presentViewController:nav animated:YES completion:nil];
}

- (IBAction)push:(id)sender {
    SCViewController *vc = [[SCViewController alloc] init];
    vc.title = @"Second VC";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor orangeColor];
    [[SCTransitionManager sharedInstance] presentViewController:nav animated:YES completion:nil];
}

@end
