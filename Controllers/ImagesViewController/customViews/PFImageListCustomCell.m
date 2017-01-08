//
//  ImageListCell.m
//  ModelProduct
//
//  Created by apple on 16/2/18.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "PFImageListCustomCell.h"
#import "PFTuKuListModel.h"


@interface PFImageListCustomCell ()

@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,strong)UILabel *lab_count;
@property (nonatomic,strong)UILabel *lab_title;
@property (nonatomic,strong)UILabel *lab_time;

@end

@implementation PFImageListCustomCell

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:_imageview];
    _imageview.contentMode=UIViewContentModeScaleAspectFill;
    _imageview.layer.masksToBounds=YES;
    
    
    _lab_count=[[UILabel alloc]initWithFrame:CGRectMake(30, 40, 30, 20)];
    [_imageview addSubview:_lab_count];
    _lab_count.font=kSYS_FONT(12);
    _lab_count.textColor=[UIColor redColor];
    _lab_count.textAlignment=NSTextAlignmentRight;
    
    _lab_title=[[UILabel alloc]initWithFrame:CGRectMake(80, 10, kSCREEN_WIDTH-80-10, 50)];
    [self addSubview:_lab_title];
    _lab_title.font=kSYS_BOLDFONT(17);
    _lab_title.numberOfLines=2;
    
    _lab_time=[[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-110, 50, 100, 20)];
    [self addSubview:_lab_time];
    _lab_time.font=kSYS_FONT(14);
    _lab_time.textAlignment=NSTextAlignmentRight;
    _lab_time.textColor=klineColor;
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(10, 79, kSCREEN_WIDTH-20, 1)];
    [self addSubview:line];
    line.backgroundColor=klineColor;

}


+ (CGFloat)cellHeight {
    return 80;
}

- (void)cellForData:(id)data {
    
    PFTuKuListModel *model=(PFTuKuListModel *)data;
    
    [self.imageview setShowActivityIndicatorView:YES];
    [self.imageview setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",tukuHeaderURL,model.img]] placeholderImage:nil];
    
    
    
//    self.lab_count.text=kFormatterSring(model.size);
//    self.lab_title.text=model.title;

    
    
    /*
    double time=kFormatterSring(model.time).doubleValue;
    NSDate *date= [NSDate  dateWithTimeIntervalSince1970:time/1000];

    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.lab_time.text= [formatter stringFromDate:date];
    */
}


@end
