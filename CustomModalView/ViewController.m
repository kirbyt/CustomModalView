//
//  ViewController.m
//  CustomModalView
//
//  Created by Kirby Turner on 5/6/13.
//  Copyright (c) 2013 White Peak Software Inc. All rights reserved.
//

#import "ViewController.h"
#import "AnotherViewController.h"
#import "UIViewController+WPSKit.h"

@interface ViewController () <WPSModalViewControllerDelegate>
@property (nonatomic, strong) UIViewController *aModalViewController;
@end

@implementation ViewController

- (void)viewDidLoad
{
   [super viewDidLoad];
   
   UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presentAnotherView:)];
   [[self navigationItem] setRightBarButtonItem:button];
}

- (IBAction)presentAnotherView:(id)sender
{
   AnotherViewController *vc = [[AnotherViewController alloc] initWithDefaultNib];
   [vc setDelegate:self];
   [vc setEdgeInsets:UIEdgeInsetsMake(100, 8, 100, 10)];
   
   UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
   
   [self setAModalViewController:navController];
   [self wps_presentModalViewController:navController completion:nil];
}

#pragma mark - WPSModalViewController Methods

- (void)modalViewControllerDidDismiss:(WPSModalViewController *)controller
{
   if (controller == [self aModalViewController]) {
      [self setAModalViewController:nil];
   }
}

@end
