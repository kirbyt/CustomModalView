//
//  WPSModalViewController.m
//  CustomModalView
//
//  Created by Kirby Turner on 5/7/13.
//  Copyright (c) 2013 White Peak Software Inc. All rights reserved.
//

#import "WPSModalViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface WPSModalViewController ()
@property (nonatomic, strong) IBOutlet UIView *containerView;
@end

@implementation WPSModalViewController

- (void)dealloc
{
   [self unregisterNotifications];
}

-(void)commonInit
{
   [self setEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
}

- (id)init
{
   self = [super init];
   if (self) {
      [self commonInit];
   }
   return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      [self commonInit];
   }
   return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
   self = [super initWithCoder:aDecoder];
   if (self) {
      [self commonInit];
   }
   return  self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   [self registerNotifications];
}

#pragma mark - Notifications

- (void)unregisterNotifications
{
   NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
   [nc removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)registerNotifications
{
   NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
   [nc addObserver:self selector:@selector(rotate:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

// TODO: Rotation support isn't working yet.
- (void)rotate:(NSNotification *)notification
{
   UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
   CGRect orientationFrame = [UIScreen mainScreen].bounds;
   CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
   
   if(UIInterfaceOrientationIsLandscape(orientation)) {
      float temp = orientationFrame.size.width;
      orientationFrame.size.width = orientationFrame.size.height;
      orientationFrame.size.height = temp;
      
      temp = statusBarFrame.size.width;
      statusBarFrame.size.width = statusBarFrame.size.height;
      statusBarFrame.size.height = temp;
   }
   
   CGFloat activeHeight = orientationFrame.size.height;
   
   CGFloat posY = floor(activeHeight*0.45);
   CGFloat posX = orientationFrame.size.width/2;
   
   CGPoint newCenter;
   CGFloat rotateAngle;
   
   switch (orientation) {
      case UIInterfaceOrientationPortraitUpsideDown:
         rotateAngle = M_PI;
         newCenter = CGPointMake(posX, orientationFrame.size.height-posY);
         break;
      case UIInterfaceOrientationLandscapeLeft:
         rotateAngle = -M_PI/2.0f;
         newCenter = CGPointMake(posY, posX);
         break;
      case UIInterfaceOrientationLandscapeRight:
         rotateAngle = M_PI/2.0f;
         newCenter = CGPointMake(orientationFrame.size.height-posY, posX);
         break;
      default: // as UIInterfaceOrientationPortrait
         rotateAngle = 0.0;
         newCenter = CGPointMake(posX, posY);
         break;
   }
   
   if(notification) {
      WPSModalViewController *__weak weakSelf=self;
      [UIView animateWithDuration:0.25f
                            delay:0
                          options:UIViewAnimationOptionAllowUserInteraction
                       animations:^{
                          [weakSelf moveToPoint:newCenter rotateAngle:rotateAngle];
                       } completion:NULL];
   }
   
   else {
      [self moveToPoint:newCenter rotateAngle:rotateAngle];
   }
   
}

- (void)moveToPoint:(CGPoint)newCenter rotateAngle:(CGFloat)angle
{
   self.view.transform = CGAffineTransformMakeRotation(angle);
   self.view.center = newCenter;
}

@end
