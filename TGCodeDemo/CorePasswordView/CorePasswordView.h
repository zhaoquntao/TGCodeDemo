//
//  CorePasswordView.h
//  CorePasswordView
//
//  Created by 冯成林 on 16/1/6.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CorePasswordView : UIView

@property (assign, nonatomic) BOOL isTradePwView;

@property (assign, nonatomic) BOOL isVerifyCode;


@property (assign, nonatomic) BOOL isDissViewBool;//是否自动消失  默认自动消失

/** 密码长度： 默认为6位 */
@property (nonatomic,assign) NSInteger passwordLength;

@property (nonatomic,copy) NSString *password;

@property (nonatomic,copy) void(^PasswordCompeleteBlock)(NSString *password);

@property (nonatomic,copy) void (^TextFieldEditChanged)(BOOL isEnd);

/** 开始输入 */
-(void)beginInput;

/** 结束输入 */
-(void)endInput;

/** 清空密码 */
-(void)clearPassword;


@end
