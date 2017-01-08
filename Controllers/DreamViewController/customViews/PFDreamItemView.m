//
//  PFDreamItemView.m
//  ModelProduct
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFDreamItemView.h"

#define itemWidth          100

#define itemHeight         42

#define itemSpaceWidht     self.width-itemWidth*2

#define itemSpaceHeight    40


@interface PFDreamItemView (){
    NSArray *titles;
}

@end

@implementation PFDreamItemView


- (void)initSubView {
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:scrollView];
    scrollView.contentSize=CGSizeMake(self.width, itemSpaceHeight+(itemHeight+itemSpaceHeight)*5);
    scrollView.showsVerticalScrollIndicator=NO;

    titles=@[@"生活类",@"建筑类",@"物品类",@"动物类",@"人物类",@"自然类",@"植物类",@"活动类",@"鬼神类",@"其他类"];
    
    NSInteger selectCount=0;
    
    for (int i=0; i<2; i++) {
        for (int j=0; j<5; j++) {
            UIView *itemView=[[UIView alloc]initWithFrame:CGRectMake((itemWidth+itemSpaceWidht)*i, itemSpaceHeight+(itemHeight+itemSpaceHeight)*j, itemWidth, itemHeight)];
            [scrollView addSubview:itemView];
            itemView.tag=100+selectCount;
            
            UIImageView *imagebg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, itemView.width, itemView.height)];
            [itemView addSubview:imagebg];
            imagebg.image=kImageName(@"PF_dream_item_bgimage");
            
            
            UILabel *lab_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, imagebg.width, imagebg.height)];
            [itemView addSubview:lab_title];
            lab_title.textAlignment=NSTextAlignmentCenter;
            lab_title.textColor=[UIColor whiteColor];
            lab_title.text=[titles objectAtIndex:selectCount];
            
            selectCount++;
            
            
            itemView.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemTapRecognizer:)];
            [itemView addGestureRecognizer:tapRecognizer];
        }
    }
    
    
    
}

- (void)itemTapRecognizer:(UITapGestureRecognizer *)recognizer {
    [_delegate didSelectPFDreamItemViewWithItemType:[titles objectAtIndex:recognizer.view.tag-100]];
}


@end
