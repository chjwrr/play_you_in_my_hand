//
//  PFCopyLabel.m
//  ModelProduct
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFCopyLabel.h"

/*
 1. Menu所处的View必须实现 – (BOOL)canBecomeFirstResponder, 且返回YES
 
 2. Menu所处的View必须实现 – (BOOL)canPerformAction:withSender, 并根据需求返回YES或NO
 
 3. 使Menu所处的View成为First Responder (becomeFirstResponder)
 
 4. 定位Menu (- setTargetRect:inView:)
 
 5. 展示Menu (- setMenuVisible:animated:)
 */

@implementation PFCopyLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self addRecognizer];
    }
    return self;
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copy:));
}

- (void)copy:(id)sender {
    UIPasteboard *pboard=[UIPasteboard generalPasteboard];
    pboard.string=self.text;
}
- (void)addRecognizer {
    UILongPressGestureRecognizer *recognizer=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longRecognizer:)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:recognizer];
}
- (void)longRecognizer:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        
        UIMenuController *menu=[UIMenuController sharedMenuController];
        [menu setTargetRect:self.frame inView:self.superview];
        [menu setMenuVisible:YES animated:YES];
    }
}
@end
