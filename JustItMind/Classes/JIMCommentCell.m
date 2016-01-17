//
//  JIMCommentCell.m
//  JustItMind
//
//  Created by Viksah on 10/16/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMCommentCell.h"
#import "TableViewCells.h"
#import "JNewsFeed.h"
#import "UIImageView+AFNetworking.h"

@implementation JIMCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadComments {
    if(_arrComments.count > 0) {
        [self.tblComments reloadData];
        [self.tblComments scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - TAbleview Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrComments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    Comment *comment = self.arrComments[indexPath.row];
    cell.lblDescription.text = comment.text;
    cell.lblTitle.text = comment.userName;
    [cell.imgView setImageWithURL:[NSURL URLWithString:comment.strProfilePic] placeholderImage:[UIImage imageNamed:@""]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

@end
