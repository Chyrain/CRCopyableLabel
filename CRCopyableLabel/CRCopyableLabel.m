//
//  CRCopyableLabel.m
//  mcss
//
//  Created by chyrain on 16/8/29.
//  Copyright © 2016年 V5KF. All rights reserved.
//

#import "CRCopyableLabel.h"
#import "V5Macros.h"

@implementation CRCopyableLabel

//绑定事件
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self attachTapHandler];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self attachTapHandler];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

// 可以响应的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copyLabel:));
}

//针对于响应方法的实现
-(void)copyLabel:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler {
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:touch];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer {
    
    [self becomeFirstResponder];
    UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                      action:@selector(copyLabel:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.bounds inView:self];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}



@end
