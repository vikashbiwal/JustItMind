//
//  TableViewCells.m
//  JustItMind
//
//  Created by Viksah on 12/27/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "TableViewCells.h"

@implementation JFeedCell

- (void)awakeFromNib {
    // Initialization code
    self.imgView.layer.cornerRadius = self.imgView.frame.size.height/2;
    self.imgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
