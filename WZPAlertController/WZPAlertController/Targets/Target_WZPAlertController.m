//
//  Target_WZPAlertController.m
//  WZPAlertController
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "Target_WZPAlertController.h"
#import <UIKit/UIKit.h>
#import "WZPAlertController.h"

static WZPAlertController *__alert;
@implementation Target_WZPAlertController

- (UIViewController *)Action_initWebAlertController:(NSDictionary *)params{
    __alert = [[WZPAlertController alloc]init];
    __alert.contentType = WZPAlertControllerContentTypeWeb;
    __alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    __alert.modalPresentationStyle = UIModalPresentationCustom;
    return __alert;
}
- (UIViewController *)Action_initTextAlertController:(NSDictionary *)params{
    __alert = [[WZPAlertController alloc]init];
    __alert.contentType = WZPAlertControllerContentTypeText;
    __alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    __alert.modalPresentationStyle = UIModalPresentationCustom;
    return __alert;
}
- (UIViewController *)Action_initImageAlertController:(NSDictionary *)params{
    __alert = [[WZPAlertController alloc]init];
    __alert.contentType = WZPAlertControllerContentTypeImage;
    __alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    __alert.modalPresentationStyle = UIModalPresentationCustom;
    return __alert;
}
- (void)Action_setAlertColors:(NSDictionary *)params{
    __alert.titleFontColor = params[@"titleFontColor"];
    __alert.titleBgColor = params[@"titleBgColor"];
    __alert.contentFontColor = params[@"contentFontColor"];
    __alert.cancelBtnFontColor = params[@"cancelBtnFontColor"];
    __alert.cancelBtnBgColor = params[@"cancelBtnBgColor"];
    __alert.confirmBtnFontColor = params[@"confirmBtnFontColor"];
    __alert.confirmBtnBgColor = params[@"confirmBtnBgColor"];
}
- (void)Action_setTapBgDontCancel:(NSDictionary *)params{
    __alert.tapBgCantCancel = true;
}
- (void)Action_setHaveNotCancelBtn:(NSDictionary *)params{
    __alert.haveNotCancelBtn = true;
}
- (void)Action_setContentString:(NSDictionary *)params{
    __alert.contentStr = params[@"contentStr"];
}
- (void)Action_setAlertCancelBlock:(NSDictionary *)params{
    __alert.cancelBlock = params[@"block"];
}
- (void)Action_setAlertConfirmBlock:(NSDictionary *)params{
    __alert.confirmBlock = params[@"block"];
}

@end
