//
//  PFImageCustomCell.m
//  ModelProduct
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFImageCustomCell.h"

#import "PFTuKuModel.h"
#define kcell_Height    215

@interface PFImageCustomCell ()

@property (nonatomic,strong)UIImageView *imageview;

@property (nonatomic,strong)UILabel *lab_title;

@end

@implementation PFImageCustomCell
- (void)initSubViews {
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kSCREEN_WIDTH-20, 200)];
    [self addSubview:_imageview];
    _imageview.contentMode=UIViewContentModeScaleAspectFill;
    _imageview.layer.cornerRadius=10;
    _imageview.layer.masksToBounds=YES;
    _imageview.backgroundColor=[UIColor redColor];

    
    UIImageView *imgVbg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 170,_imageview.width, 30)];
    [_imageview addSubview:imgVbg];
    imgVbg.backgroundColor=[UIColor blackColor];
    imgVbg.alpha=0.3;
    
    _lab_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 170,_imageview.width-10, 30)];
    _lab_title.textColor = [UIColor whiteColor];
    [_imageview addSubview:_lab_title];
    _lab_title.textAlignment=NSTextAlignmentRight;
    _lab_title.font=kSYS_BOLDFONT(14);

}


- (void)cellForData:(id)data {
    
    PFTuKuModel *model=(PFTuKuModel *)data;
    
    _imageview.image=kImageName(model.imageName);
    _lab_title.text=model.title;
}


+(CGFloat)cellHeight {
    return kcell_Height;
}



@end
