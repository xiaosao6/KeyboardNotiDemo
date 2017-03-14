//
//  KeyBoardNotiUtil.h
//  KeyboardNotiDemo
//
//  Created by sischen on 17/3/5.
//  Copyright © 2017年 demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 键盘弹出通知工具类
 */
@interface KeyBoardNotiUtil : NSObject

@property (nonatomic, strong) UIView *targetView;//!<响应键盘高度变化的view
@property (nonatomic, assign) CGFloat delaySec;//!<设置延迟是为了优化搜狗等第三方键盘弹起时高度获取不正确的问题

+(KeyBoardNotiUtil *)sharedUtil;

@end





