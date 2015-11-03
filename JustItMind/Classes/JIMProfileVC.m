//
//  JIMProfileVC.m
//  JustItMind
//
//  Created by Viksah on 11/3/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMProfileVC.h"

@interface JIMProfileVC ()
{
    
    IBOutlet UIImageView *coverImageView;
    IBOutlet NSLayoutConstraint *coverimageHeight;
    
}
@end

@implementation JIMProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
