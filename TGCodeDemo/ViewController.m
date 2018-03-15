//
//  ViewController.m
//  TGCodeDemo
//
//  Created by 赵群涛 on 2018/1/11.
//  Copyright © 2018年 QR. All rights reserved.
//

#import "ViewController.h"
#import "BankSMSCodePopView.h"
#import "TGActionTool.h"

#define WS(weakSelf) __weak __typeof(self)weakSelf = self;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}




- (IBAction)btn:(id)sender {
    
    
    
    BankSMSCodePopView *smsPopView = nil;
    smsPopView = [BankSMSCodePopView bankPopupWithParentVC:self sureBlock:^(NSString *smsCode) {
        NSLog(@"%@",smsCode);
        
    } cancelBlock:^{
        NSLog(@"cacle");
    } resendBlock:^(id popView) {
        NSLog(@"regain");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
