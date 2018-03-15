//
//  BankSMSCodePopView.h
//  CashLoanApp
//
//  Created by 赵群涛 on 2018/1/11.
//  Copyright © 2018年 QR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JQUnitField.h"
typedef void(^BankSMSPopupSureBlock)(NSString *smsCode);
typedef void(^BankSMSPopupCancelBlock)(void);
typedef void(^BankSMSPopupResendBlock)(id popView);
@interface BankSMSCodePopView : UIView<JQUnitFieldDelegate>


+(instancetype)bankPopupWithParentVC:(UIViewController *)parentVC sureBlock:(BankSMSPopupSureBlock)sureBlock cancelBlock:(BankSMSPopupCancelBlock)cancelBlock resendBlock:(BankSMSPopupResendBlock) resendBlock;



@end
