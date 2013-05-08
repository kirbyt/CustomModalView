//
//  WPSModalViewController.h
//  CustomModalView
//
//  Created by Kirby Turner on 5/7/13.
//  Copyright (c) 2013 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WPSModalViewControllerDelegate;

@interface WPSModalViewController : UIViewController

@property (nonatomic, weak) id <WPSModalViewControllerDelegate> delegate;
@property (nonatomic, strong) UIView *scrimView;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@protocol WPSModalViewControllerDelegate <NSObject>
@required
- (void)modalViewControllerDidDismiss:(WPSModalViewController *)controller;
@end