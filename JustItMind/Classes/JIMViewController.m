//
//  ViewController.m
//  JustItMind
//
//  Created by Viksah on 9/24/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMViewController.h"
#define mainScreen [UIScreen mainScreen].bounds

@interface JIMViewController ()
{
    IBOutlet NSLayoutConstraint *unversityIDBckgrndTopSpaceConstraint;
    IBOutlet NSLayoutConstraint *unversityIDBckgrndLeadignSpaceConstraint;
    
    IBOutlet NSLayoutConstraint *confirmCodeBckgrndTopSpaceConstraint;
    IBOutlet NSLayoutConstraint *confirmCodeBckgrndLeadingSpaceConstraint;
    
}
@end

@implementation JIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)onGetCodeBtnClick:(id)sender
{
    [self performSegueWithIdentifier:@"nextSegue" sender:nil];
}

- (IBAction)onLetsGoBtnClick:(id)sender
{
    [self performSegueWithIdentifier:@"nextToProfileSegue" sender:nil];
}
- (void)setUI
{

    if(mainScreen.size.width == 375)
    {
        confirmCodeBckgrndTopSpaceConstraint.constant     = 48;
        confirmCodeBckgrndLeadingSpaceConstraint.constant = 180;
        unversityIDBckgrndTopSpaceConstraint.constant     = 38;
        unversityIDBckgrndLeadignSpaceConstraint.constant = 101;
    }
    if(mainScreen.size.width == 414)
    {
        confirmCodeBckgrndTopSpaceConstraint.constant     = 65;
        confirmCodeBckgrndLeadingSpaceConstraint.constant = 200;
        unversityIDBckgrndTopSpaceConstraint.constant     = 55;
        unversityIDBckgrndLeadignSpaceConstraint.constant = 111;
    }
    
}

@end
