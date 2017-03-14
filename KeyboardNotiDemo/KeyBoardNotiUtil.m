//
//  KeyBoardNotiUtil.m
//  KeyboardNotiDemo
//
//  Created by sischen on 17/3/5.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "KeyBoardNotiUtil.h"

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)

@interface UIResponder (WTYFirstResponder)

+ (id)wty_currentFirstResponder;

@end

static __weak id wty_currentFirstResponder;

@implementation UIResponder (WTYFirstResponder)

+ (id)wty_currentFirstResponder {
    wty_currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(wty_findFirstResponder:) to:nil from:nil forEvent:nil];
    return wty_currentFirstResponder;
}

- (void)wty_findFirstResponder:(id)sender {
    wty_currentFirstResponder = self;
}

@end





@implementation KeyBoardNotiUtil

+(KeyBoardNotiUtil *)sharedUtil{
    static dispatch_once_t onceToken;
    static KeyBoardNotiUtil *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[KeyBoardNotiUtil alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(keyWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(keyWillHide) name:UIKeyboardWillHideNotification object:nil];
    });
    return instance;
}

-(void)keyWillShow:(NSNotification *)noti{
    UIView *responder = [self firstResponderInWindow];
    CGRect  respframe = responder.frame;
    CGFloat bottom2Screen = SCREEN_HEIGHT - CGRectGetMaxY(respframe);
    
    CGFloat kbHeight = [self keyShowHeight:noti];
    CGFloat animTime = [self keyShowAnimationTime:noti];
    
    if (_delaySec > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delaySec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performAnimation:bottom2Screen KeyH:kbHeight Duration:animTime];
        });
    }else{
        [self performAnimation:bottom2Screen KeyH:kbHeight Duration:animTime];
    }
}

-(void)keyWillHide{
    _targetView.transform = CGAffineTransformMakeTranslation(0, 0);
}

-(void)performAnimation:(CGFloat)bottom2Screen KeyH:(CGFloat)kbHeight Duration:(CGFloat)animTime{
    if (bottom2Screen - kbHeight < 0) { //当响应者底部被挡住时，需要上升
        void(^animation)(void) = ^void(void){
            _targetView.transform = CGAffineTransformMakeTranslation(0, bottom2Screen - kbHeight);
        };
        
        if (animTime > 0) {[UIView animateWithDuration:animTime animations:animation];}
        else { animation(); }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - Private

-(UIView *)firstResponderInWindow{
    id responder = [UIResponder wty_currentFirstResponder];
    if ([responder isKindOfClass:UIView.class]) { return (UIView *)responder; }
    return nil;
}

-(CGFloat)keyShowAnimationTime:(NSNotification *)noti{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:noti.userInfo];
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    return animationTime;
}

-(CGFloat)keyShowHeight:(NSNotification *)noti{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:noti.userInfo];
    CGRect  keyBoardBounds = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    return keyBoardHeight;
}

@end
