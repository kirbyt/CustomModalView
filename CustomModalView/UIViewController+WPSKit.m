//
//  UIViewController+WPSKit.m
//  CustomModalView
//
//  Created by Kirby Turner on 5/6/13.
//  Copyright (c) 2013 White Peak Software Inc. All rights reserved.
//

#import "UIViewController+WPSKit.h"
#import "WPSModalViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIViewController (WPSKit)

- (void)wps_presentModalViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion
{
   NSParameterAssert(viewControllerToPresent);
   
   UIApplication *app = [UIApplication sharedApplication];
   UIView *keyWindow = [app keyWindow];
   CGRect frame = [keyWindow frame];

   UIEdgeInsets insets = UIEdgeInsetsZero;
   
   UIView *scrim = [[UIView alloc] initWithFrame:[keyWindow bounds]];
   [scrim setTranslatesAutoresizingMaskIntoConstraints:YES];
   [scrim setBackgroundColor:[UIColor blackColor]];
   [scrim setAlpha:0.0f];
   [keyWindow addSubview:scrim];

   BOOL isNavigationController = [viewControllerToPresent isKindOfClass:[UINavigationController class]];
   UIViewController *rootViewController = viewControllerToPresent;
   if (isNavigationController) {
      rootViewController = [(UINavigationController *)viewControllerToPresent topViewController];
   }

   if ([rootViewController isKindOfClass:[WPSModalViewController class]]) {
      WPSModalViewController * vc = (WPSModalViewController *)rootViewController;
      [vc setScrimView:scrim];
      insets = [vc edgeInsets];
   }

   frame = CGRectMake(frame.origin.x + insets.left,
                      frame.origin.y + insets.top,
                      frame.size.width - insets.right - insets.left,
                      frame.size.height - insets.bottom - insets.top);

   UIView *viewToAnimate = [viewControllerToPresent view];
   
   // Move it off the screen.
   frame.origin.y = -frame.size.height;
   [viewToAnimate setFrame:frame];
   
   UIView *shadowView = [[UIView alloc] initWithFrame:frame];
   [shadowView setBackgroundColor:[UIColor colorWithWhite:0 alpha:1.0]];
   if ([rootViewController isKindOfClass:[WPSModalViewController class]]) {
      WPSModalViewController * vc = (WPSModalViewController *)rootViewController;
      [vc setShadowView:shadowView];
   }
   

   [keyWindow addSubview:shadowView];
   [keyWindow addSubview:viewToAnimate];

   UIInterfaceOrientation orientation = [self interfaceOrientation];
   BOOL isLandscape = UIInterfaceOrientationIsLandscape(orientation);

   CGRect statusBarFrame = [app statusBarFrame];
   CGFloat statusBarHeight;
   if (isLandscape) {
      statusBarHeight = statusBarFrame.size.width;
   } else {
      statusBarHeight = statusBarFrame.size.height;
   }
   
   frame.origin.y = statusBarHeight + insets.top;
   frame.size.height -= statusBarHeight;

   
   CALayer *layer = [viewToAnimate layer];
   [layer setCornerRadius:10];
   [layer setMasksToBounds:YES];

   CALayer *shadowLayer = [shadowView layer];
   [shadowLayer setCornerRadius:10];
   [shadowLayer setMasksToBounds:NO];
   [shadowLayer setShadowColor:[[UIColor blackColor] CGColor]];
   [shadowLayer setShadowOpacity:0.8f];
   [shadowLayer setShadowRadius:5];
   [shadowLayer setShadowOffset:CGSizeZero];

   [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
      [viewToAnimate setFrame:frame];
      [shadowView setFrame:frame];
      [scrim setAlpha:0.6f];
   } completion:^(BOOL finished) {
      
   }];
}

- (void)wps_dismissModalViewControllerWithCompletion:(void (^)(void))completion
{
   UIView *scrim = nil;
   UIView *shadowView = nil;
   if ([self isKindOfClass:[WPSModalViewController class]]) {
      scrim = [(WPSModalViewController *)self scrimView];
      shadowView = [(WPSModalViewController *)self shadowView];
   }
   
   
   UIView *viewToAnimate = [self view];
   if ([self parentViewController]) {
      viewToAnimate = [[self parentViewController] view];
   }
   CGRect frame = [viewToAnimate frame];
   frame.origin.y = -frame.size.height;

   [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
      [viewToAnimate setFrame:frame];
      [shadowView setFrame:frame];
      [scrim setAlpha:0.0];
   } completion:^(BOOL finished) {
      [viewToAnimate removeFromSuperview];
      [shadowView removeFromSuperview];
      [scrim removeFromSuperview];
   }];
}

@end
