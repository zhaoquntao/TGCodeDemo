//
//  BankSMSCodePopView.m
//  CashLoanApp
//
//  Created by 赵群涛 on 2018/1/11.
//  Copyright © 2018年 QR. All rights reserved.
//
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "BankSMSCodePopView.h"
#import "BAButton.h"
#import "LewPopupViewAnimationFade.h"
#define WS(weakSelf) __weak __typeof(self)weakSelf = self;
UIViewController *BankSMSPop_parentViewController;
@interface BankSMSCodePopView()
@property (weak, nonatomic) IBOutlet UIButton *againButton;

@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (weak, nonatomic) IBOutlet JQUnitField *codeTextField;


@property(nonatomic,assign) BOOL sureBtnClicked;//是否点击确定按钮
@property(nonatomic,strong) NSString *smsCode;//短信验证码

@property(nonatomic,copy) BankSMSPopupSureBlock sureBlock;
@property(nonatomic,copy) BankSMSPopupCancelBlock cancelBlock;
@property(nonatomic,copy) BankSMSPopupResendBlock resendBlock;
@end


@implementation BankSMSCodePopView{
    NSTimer *countDownTimer;
    int countSecond;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    countSecond = 60;
    self.codeTextField.delegate = self;
    self.codeTextField.cursorColor = [UIColor blueColor];
    
//    [_sureButton ba_button_setViewRectCornerType:BAKit_ViewRectCornerTypeTopRight viewCornerRadius:10];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_sureButton.bounds byRoundingCorners: UIRectCornerBottomLeft  cornerRadii:CGSizeMake(10.0, 10.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _sureButton.bounds;
    maskLayer.path = maskPath.CGPath;
    _sureButton.layer.mask = maskLayer;
    


}

+(instancetype)bankPopupWithParentVC:(UIViewController *)parentVC sureBlock:(BankSMSPopupSureBlock)sureBlock cancelBlock:(BankSMSPopupCancelBlock)cancelBlock resendBlock:(BankSMSPopupResendBlock) resendBlock{
    BankSMSPop_parentViewController = parentVC;
    LewPopupViewAnimationFade *animation = [[LewPopupViewAnimationFade alloc] init];
    BankSMSCodePopView *popupView = [[[NSBundle mainBundle] loadNibNamed:@"BankSMSCodePopView" owner:self options:nil] firstObject];
    popupView.frame = CGRectMake(0, -30, 300, 180);
    
    popupView.cancelBlock = cancelBlock;
    popupView.sureBlock = sureBlock;
    popupView.resendBlock = resendBlock;
    [popupView.codeTextField becomeFirstResponder];
    [parentVC lew_presentPopupView:popupView animation:animation dismissed:^{
        //确认消失才回调-防止弹窗两次会一起消失
        if (popupView.sureBtnClicked) {
            if (popupView.sureBlock) {
                popupView.sureBlock(popupView.smsCode);
            }
        }
    }];
    [popupView startCountDownTimer];//开始倒计时
    return popupView;
}

- (IBAction)againBtnClick:(UIButton *)sender {
    if(_resendBlock){
        _resendBlock(self);
    }
}


- (IBAction)cacleBtnClick:(UIButton *)sender {
    [self startCountDownTimer];
    self.sureBtnClicked = NO;
    [self dismissView];
    if (_cancelBlock) {
        _cancelBlock();
    }
    
}
- (IBAction)sureBtnClick:(UIButton *)sender {
    
    [self.codeTextField resignFirstResponder];
//    self.smsCode = [self.codeTextField.text trim];
    
    self.sureBtnClicked = YES;//消失的时候再回调
    [self dismissView];
    
}


//倒计时处理
-(void)startCountDownTimer{
    if(countDownTimer){
        [countDownTimer invalidate];
        countDownTimer = nil;
    }
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleCountDown) userInfo:nil repeats:YES];
    self.againButton.userInteractionEnabled = NO;
}

-(void)handleCountDown{
    if (countSecond == 0) {
        [self.againButton setTitleColor:kUIColorFromRGB(0x3387FF) forState:UIControlStateNormal];
        [self.againButton setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        self.againButton.userInteractionEnabled = YES;
        countSecond = 60;
        [countDownTimer invalidate];
    }else{
        [self.againButton setTitle:[NSString stringWithFormat:@"%d后重新发送",--countSecond] forState:UIControlStateNormal];
        [self.againButton setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    }
}

//消失视图
-(void)dismissView{

    LewPopupViewAnimationFade *animation = [[LewPopupViewAnimationFade alloc] init];
    [BankSMSPop_parentViewController lew_dismissPopupViewWithanimation:animation];
}

#pragma mark textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)unitField:(JQUnitField *)uniField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}
- (IBAction)unitFieldEditingChanged:(JQUnitField *)sender {

    if (sender.text.length > 5) {
        self.smsCode = sender.text;
    }
}

@end
