//
//  AnotherViewController.m
//  CustomModalView
//
//  Created by Kirby Turner on 5/7/13.
//  Copyright (c) 2013 White Peak Software Inc. All rights reserved.
//

#import "AnotherViewController.h"
#import "UIViewController+WPSKit.h"

@interface AnotherViewController ()

@end

@implementation AnotherViewController

- (id)initWithDefaultNib
{
   self = [super initWithNibName:@"AnotherViewController" bundle:nil];
   if (self) {
      
   }
   return self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   
   UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
   [[self navigationItem] setLeftBarButtonItem:doneButton];
}

- (IBAction)done:(id)sender
{
   [self wps_dismissModalViewControllerWithCompletion:nil];
}

- (IBAction)push:(id)sender
{
   UIViewController *vc = [[UIViewController alloc] init];
   [[vc view] setBackgroundColor:[UIColor redColor]];
   [[self navigationController] pushViewController:vc animated:YES];
}

@end
