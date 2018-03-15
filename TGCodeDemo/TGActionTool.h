//
//  TGActionTool.h
//  TGActionSheet
//
//  Created by 赵群涛 on 2017/5/29.
//  Copyright © 2017年 ZQT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  弹框显示的时间，默认1秒
 */
#define AlertViewShowTime 1.0

/**
 *  回调block
 */
typedef void (^CallBackBlock)(NSInteger btnIndex);

/**
 *  按钮样式，不用系统的是为了版本适配
 */
typedef enum {
    TGTAlertActionStyleDefault = 0,
    TGTAlertActionStyleCancel,
    TGTAlertActionStyleDestructive
}TGTAlertActionStyle;


@interface TGActionTool : NSObject

/**
 *  简易（最多支持单一按钮,按钮无执行响应）alert定义 兼容适配
 *
 *  @param viewController       当前视图，alertController模态弹出的指针
 *  @param title                标题
 *  @param message              信息
 *  @param btnTitle             按钮标题
 *  @param btnStyle             按钮样式
 */
+ (void)showTipAlertViewWith:(UIViewController *)viewController
                       title:(NSString *)title
                     message:(NSString *)message
                 buttonTitle:(NSString *)btnTitle
                 buttonStyle:(TGTAlertActionStyle)btnStyle;


/**
 *  actionSheet实现 底部简易提示窗 无按钮
 *
 *  @param viewController 当前视图，alertController模态弹出的指针
 *  @param title          标题
 *  @param message        信息，iOS8之前设置无效
 */
+ (void)showBottomTipViewWith:(UIViewController *)viewController
                        title:(NSString *)title
                      message:(NSString *)message;

+ (void)showAlertWith:(UIViewController *)viewController
                title:(NSString *)title
              message:(NSString *)message
        callbackBlock:(CallBackBlock)block
    cancelButtonTitle:(NSString *)cancelBtnTitle
destructiveButtonTitle:(NSString *)destructiveBtn
    otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

/**
 *  普通 actionSheet 兼容适配
 *
 *  @param viewController      当前视图，alertControll模态弹出的指针
 *  @param title               标题
 *  @param message             信息
 *  @param block               用于执行方法的回调block
 *  @param destructiveBtnTitle 特殊按钮
 *  @param cancelBtnTitle      取消按钮标题
 *  @param otherButtonTitles   其他按钮，变参
 
 ***注意***
 message
 iOS8以前，actionSheet设置无效，因为不支持
 iOS8以后，actionSheet设置有效
 */
+ (void)showActionSheetWith:(UIViewController *)viewController
                      title:(NSString *)title
                    message:(NSString *)message
              callbackBlock:(CallBackBlock)block
     destructiveButtonTitle:(NSString *)destructiveBtnTitle
          cancelButtonTitle:(NSString *)cancelBtnTitle
          otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

/**
 *  多按钮列表数组排布actionSheet初始化 兼容适配
 *
 *  @param viewController       当前视图，alertController模态弹出的指针
 *  @param title                标题
 *  @param message              详细信息
 *  @param block                用于执行方法的回调block
 *  @param cancelBtnTitle       取消按钮
 *  @param destructiveBtnTitle  特殊（只针对actionSheet）ios8之后设置无效
 *  @param otherBtnTitleArray   其他按钮数组
 *  @param otherBtnStyleArray   按钮样式数组（普通/特殊），alertView默认为普通样式
 

 */
+ (void)showArrayActionSheetWith:(UIViewController *)viewController
                           title:(NSString *)title
                         message:(NSString *)message
                   callbackBlock:(CallBackBlock)block
               cancelButtonTitle:(NSString *)cancelBtnTitle
          destructiveButtonTitle:(NSString *)destructiveBtnTitle
           otherButtonTitleArray:(NSArray *)otherBtnTitleArray
           otherButtonStyleArray:(NSArray *)otherBtnStyleArray;


/**
 *  判断当前是否有alert显示，可以用来去重显示
 *  去重显示时，此方法慎用，因为未做弹窗区分，同时的弹窗有可能是因为重复显示，也可能是不同警告类型的提示窗
 *  用此只能判断出当前页面是否有弹窗显示，不能区分弹窗的类型（是否是同一类型提示）
 *
 *  @return yes -> 有提示窗显示
 */
+ (BOOL)isAlertShowNow;


/**
 *  查找当前活动窗口
 *
 *  @return 窗口vc
 */
+ (UIViewController *)activityViewController;



@end
