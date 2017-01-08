//
//  BaseCell.m
//  ModelProduct
//
//  Created by chj on 15/12/30.
//  Copyright © 2015年 chj. All rights reserved.
//

#import "PFBaseCell.h"

@implementation PFBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
        
        self.backgroundColor=[UIColor clearColor];
        self.contentView.backgroundColor=[UIColor clearColor];
    }
    return self;
}
- (void)initSubViews {
    
}

- (void)cellForData:(id)data {
    
}

+ (CGFloat)cellHeightForData:(id)data {
    return 44;
}

+ (CGFloat)cellHeight {
    return 44;
}
@end
