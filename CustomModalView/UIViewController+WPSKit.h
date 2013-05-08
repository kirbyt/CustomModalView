//
//  UIViewController+WPSKit.h
//  CustomModalView
//
//  Created by Kirby Turner on 5/6/13.
//  Copyright (c) 2013 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WPSKit)

- (void)wps_presentModalViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion;
- (void)wps_dismissModalViewControllerWithCompletion:(void (^)(void))completion;

@end
