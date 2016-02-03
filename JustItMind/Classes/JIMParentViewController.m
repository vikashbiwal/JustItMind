//
//  SCParentViewController.m
//  ShiftCalendar
//
//  Created by iOSDeveloper2 on 07/10/13.
//  Copyright (c) 2013 Yudiz Pvt. Solution Ltd. All rights reserved.
//

#import "JIMParentViewController.h"

@interface JIMParentViewController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIActivityIndicatorView     *_actInd;
    UILabel                     *_lblProgress;
    UIImageView *_roundActInd;
    UILabel *_lblActInd;
    CABasicAnimation *rotationAnimation;

}

@end


@implementation JIMParentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setScrollsToTop:YES];
    [self.tableView setTableFooterView:[UIView new]];
    [self configureActivityIndicator];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    _lblProgress = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [_lblProgress setText:@""];
    [_lblProgress setBackgroundColor:[UIColor darkGrayColor]];
    [_lblProgress setAlpha:1];
    [_lblProgress.layer setCornerRadius:5];
    [_lblProgress setCenter:self.view.center];
    [_lblProgress setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin];
    _actInd  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [_actInd setCenter:self.view.center];
    [_actInd setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin];
    
    
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)showHud
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [_lblProgress setCenter:self.view.center];
    [_actInd setCenter:self.view.center];
    [self.view addSubview:_lblProgress];
    [self.view addSubview:_actInd];
    [_actInd  startAnimating];
    [self.view setUserInteractionEnabled:NO];
}

-(void)hideHud
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [_lblProgress removeFromSuperview];
    [_actInd removeFromSuperview];
    [_actInd stopAnimating];
    [self.view setUserInteractionEnabled:YES];
}

-(void)showHudWithUI
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [_lblProgress setCenter:self.view.center];
    [_actInd setCenter:self.view.center];
    [self.view addSubview:_lblProgress];
    [self.view addSubview:_actInd];
    [_actInd  startAnimating];
}


#pragma mark - IBActions

-(IBAction)parentBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)parentDismissAction:(id)sender
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)parentBackDismissAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)parentRootBackAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - TextField delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)configureActivityIndicator{
    
    //Configuring Activity Indicator...
    /*HUD = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
     HUD.labelText = @"Please Wait...";
     HUD.dimBackground = YES;
     HUD.userInteractionEnabled = NO;
     .0
     [HUD setHidden:TRUE];*/
   
    /*_roundActInd = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ActivityIndicator.png"]];
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithDouble:(M_PI * 2.0 * 0.2)];
    rotationAnimation.duration = 0.2;
    rotationAnimation.cumulative = true;
    rotationAnimation.repeatCount = 999999;
    */
   
    _lblActInd = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _lblActInd.backgroundColor = [UIColor blackColor];

    _lblActInd.layer.cornerRadius = 5.0;
    _lblActInd.layer.borderColor = [UIColor grayColor].CGColor;
    _lblActInd.layer.borderWidth = 1.0;
    _lblActInd.layer.masksToBounds = YES;
    //_actInd = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //[_actInd setColor:[UIColor redColor]];
}
-(void)startActivity{
    if (![UIApplication sharedApplication].isIgnoringInteractionEvents) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [_lblActInd setCenter:self.view.center];
    [self.view addSubview:_lblActInd];
   
    [_actInd setCenter:self.view.center];
    [self.view addSubview:_actInd];
    [_actInd startAnimating];
    /*_roundActInd.center = self.view.center;
    [self.view addSubview:_roundActInd];
    [_roundActInd.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];*/
}

-(void)stopActivity{
    //[_roundActInd.layer removeAllAnimations];
    //[_roundActInd removeFromSuperview];
    [_lblActInd removeFromSuperview];
    [_actInd removeFromSuperview];
    [_actInd stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if ([UIApplication sharedApplication].isIgnoringInteractionEvents) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
}

- (NSArray *)sortArray:(NSArray*)array fieldName:(NSString*)strKey {
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:strKey ascending:NO];
    id arr =  [array sortedArrayUsingDescriptors:@[des]];
    return arr;
}

#pragma mark - utility methods
-(BOOL)checkTextfieldValue:(UITextField *)textField{
    
    if ([textField.text isEqualToString:@""] || textField.text.length == 0 || textField.text == nil) {
        return TRUE;
    }
    else{
        return FALSE;
    }
}

-(BOOL)validateEmail:(NSString *)candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

-(void)showAletViewWithMessage: (NSString*) msg
{
    [[[UIAlertView alloc]initWithTitle:@"PublicFeed"
                               message:msg
                              delegate:nil
                     cancelButtonTitle:@"Cancel"
                     otherButtonTitles:nil, nil]show];
    
}
//-(IBAction)shutterAction:(id)sender
//{
//    PFContainerViewController *containerController = [self findContainerController];
//    
//    if(containerController)
//        [self animatedDrawerEffectForView:containerController.mainContainer];
//}
//
//-(PFContainerViewController*)findContainerController
//{
//    
//    __block __weak PFContainerViewController *containerController = nil;
//    
//    UINavigationController* navCon = (UINavigationController *)Appdelegate.window.rootViewController;
//    
//    [navCon.viewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop)
//     {
//         if([obj isKindOfClass:[PFContainerViewController class]])
//             containerController = (PFContainerViewController*)obj;
//     }];
//    return containerController;
//}

//-(void)animatedDrawerEffectForView:(UIView*)animatedView
//{
//    PFContainerViewController *containerController = [self findContainerController];
//    CGFloat thresholdPont = 270;
//    [self.view endEditing:YES];
//    CGRect rect = animatedView.frame;
//    if(rect.origin.x!=thresholdPont) {
//         [self.tabBarController.view addSubview:containerController->transperantView];
//        [UIView animateWithDuration:0.2 animations:^{
//            [animatedView setFrame:CGRectMake(thresholdPont+5, 0, rect.size.width, rect.size.height)];
//            // [containerController.menuContainer setFrame:CGRectMake(0, 0, containerController.menuContainer.frame.size.width, containerController.menuContainer.frame.size.height)];
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.1 animations:^{
//                [animatedView setFrame:CGRectMake(thresholdPont-5, rect.origin.y, rect.size.width, rect.size.height)];
//            }completion:^(BOOL finished){
//                [UIView animateWithDuration:0.1 animations:^{
//                    [animatedView setFrame:CGRectMake(thresholdPont, rect.origin.y, rect.size.width, rect.size.height)];
//                }];
//            }];
//        }];
//    }
//    else {
//         [containerController->transperantView removeFromSuperview];
//        [UIView animateWithDuration:0.3 animations:^{
//            //[containerController.menuContainer setFrame:CGRectMake(-260.0, 0, containerController.menuContainer.frame.size.width, containerController.menuContainer.frame.size.height)];
//            [animatedView setFrame:CGRectMake(0,rect.origin.y, rect.size.width, rect.size.height)];
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.2 animations:^{
//                [animatedView setFrame:CGRectMake(0,rect.origin.y, rect.size.width, rect.size.height)];
//            }];
//        }];
//    }
//}
//

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Shake motion methods
@end
