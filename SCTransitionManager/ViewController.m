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

- (IBAction)zoomPresent:(id)sender {
    SCViewController *vc = [[SCViewController alloc] init];
    vc.title = @"Second VC";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor orangeColor];
    
    [SCTransition presentViewController:nav sourceView:self.avatarView targetView:vc.avatarView animated:YES completion:nil];
}

- (IBAction)normalPresent:(id)sender {
    SCViewController *vc = [[SCViewController alloc] init];
    vc.title = @"Second VC";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor orangeColor];
    
    [SCTransition presentViewController:nav animated:YES completion:nil];
}

- (IBAction)zoomPush:(id)sender {
    SCViewController *vc = [[SCViewController alloc] init];
    vc.title = @"Second VC";
    vc.view.backgroundColor = [UIColor orangeColor];
    [SCTransition pushViewController:vc sourceView:self.avatarView targetView:vc.avatarView animated:YES];
}

- (IBAction)normalPush:(id)sender {
    SCViewController *vc = [[SCViewController alloc] init];
    vc.title = @"Second VC";
    vc.view.backgroundColor = [UIColor orangeColor];
    [SCTransition pushViewController:vc animated:YES];
}

@end
