//
//  JIMNewsFeedVC.m
//  JustItMind
//
//  Created by Viksah on 9/28/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMNewsFeedVC.h"

@interface JIMNewsFeedVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet NSLayoutConstraint *tableviewWidth;
    IBOutlet NSLayoutConstraint *topMenuTopSpace;
}
@end

@implementation JIMNewsFeedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    topMenuTopSpace.constant = -50;
    tableviewWidth.constant = screenSize.size.width;
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
}


#pragma mark - TAbleview Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventFeedCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row%2 == 0)
//    {
//    [self performSegueWithIdentifier:@"EventDetailSegue" sender:nil];
//    }
//    else
//    {
//        [self performSegueWithIdentifier:@"advertSegue" sender:nil];
//        
//    }
}

- (IBAction)onTopMenuShutterBtn:(id)sender
{
    static BOOL isOpend = NO;
    if(isOpend)
    {
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = -50;
            [self.view layoutIfNeeded];
        }];
        isOpend = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = 64;
            [self.view layoutIfNeeded];
        }];
        isOpend = YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
