//
//  JIMEventDeailVC.m
//  JustItMind
//
//  Created by Viksah on 10/16/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMEventDeailVC.h"

@interface JIMEventDeailVC ()
{
    IBOutlet UIView *commentAddView;
    IBOutlet UIImageView *coverImageView;
    IBOutlet NSLayoutConstraint *coverimageHeight;
    
}
@end

@implementation JIMEventDeailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [DefaultCenter addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [DefaultCenter addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    commentAddView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TAbleview Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenSize.size.height - 386;
}

- (void)scrollViewDidScroll:(UIScrollView*)tablview
{
    CGFloat y = -tablview.contentOffset.y;
    NSLog(@"tableview offset y = %f",tablview.contentOffset.y);
    
        coverimageHeight.constant =  115+y;
    
   
}
#pragma mark - IBActions

- (IBAction)commentEditingBegin:(id)sender {
    commentAddView.hidden = NO;
}



#pragma mark - UIKeyboard notification

- (void)keyboardShow:(NSNotification*)notify
{
   
}

- (void)keyboardHide:(NSNotification*)notify
{
    commentAddView.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [DefaultCenter removeObserver:self];
}
@end
