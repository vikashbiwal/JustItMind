//
//  JIMChatSenderCell.m
//  JustItMind
//
//  Created by Viksah on 10/29/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMChatCell.h"

@implementation JIMChatCell

- (void)awakeFromNib {
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height/2;
    self.profilePic.clipsToBounds  = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
