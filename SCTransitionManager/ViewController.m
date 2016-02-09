//
//  ViewController.m
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/5.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "ViewController.h"
#import "SCTransition.h"
#import "SCViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Main VC";
}

- (IBAction)present:(id)sender {
    SCViewController *vc = [[SCViewController alloc] init];
    vc.title = @"Second VC";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor orangeColor];
    
    [SCTransition presentViewController:nav sourceView:self.avatarView sourceVC:self targetView:vc.imageView targetVC:vc targetFrame:CGRectMake(0, 64, 320, 320) completion:nil];
}

- (IBAction)push:(id)sender {
    SCViewController *vc = [[SCViewController alloc] init];
    vc.title = @"Second VC";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor orangeColor];
    
    [SCTransition presentViewController:nav animated:YES completion:nil];
}

@end
