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

/**
 初始化web弹框

 @param params nil
 @return alertController
 */
- (UIViewController *)Action_initWebAlertController:(NSDictionary *)params{
    __alert = [[WZPAlertController alloc]init];
    __alert.contentType = WZPAlertControllerContentTypeWeb;
    __alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    __alert.modalPresentationStyle = UIModalPresentationCustom;
    
    return __alert;
}

/**
 初始化text弹框
 
 @param params nil
 @return alertController
 */
- (UIViewController *)Action_initTextAlertController:(NSDictionary *)params{
    __alert = [[WZPAlertController alloc]init];
    __alert.contentType = WZPAlertControllerContentTypeText;
    __alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    __alert.modalPresentationStyle = UIModalPresentationCustom;
    
    return __alert;
}

/**
 初始化image弹框
 
 @param params nil
 @return alertController
 */
- (UIViewController *)Action_initImageAlertController:(NSDictionary *)params{
    __alert = [[WZPAlertController alloc]init];
    __alert.contentType = WZPAlertControllerContentTypeImage;
    __alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    __alert.modalPresentationStyle = UIModalPresentationCustom;
    
    return __alert;
}

/**
 设置弹框相关颜色
 
 @param params 弹框颜色键值
 */
- (void)Action_setAlertColors:(NSDictionary *)params{
    __alert.titleFontColor = params[@"titleFontColor"];
    __alert.titleBgColor = params[@"titleBgColor"];
    __alert.contentFontColor = params[@"contentFontColor"];
    __alert.cancelBtnFontColor = params[@"cancelBtnFontColor"];
    __alert.cancelBtnBgColor = params[@"cancelBtnBgColor"];
    __alert.confirmBtnFontColor = params[@"confirmBtnFontColor"];
    __alert.confirmBtnBgColor = params[@"confirmBtnBgColor"];
}

/**
 设置弹框背景点击不消失
 
 @param params nil
 */
- (void)Action_setTapBgDontCancel:(NSDictionary *)params{
    __alert.tapBgCantCancel = true;
}

/**
 设置没有取消按钮
 
 @param params nil
 */
- (void)Action_setHaveNotCancelBtn:(NSDictionary *)params{
    __alert.haveNotCancelBtn = true;
}

/**
 设置弹框内容、标题文字、取消/确认按钮文字
 @alert contentStr web类型,URLString; image类型,image地址string; text类型,text内容string
 @param params 相关文字键值
 */
- (void)Action_setContentStringAndSomeTitle:(NSDictionary *)params{
    __alert.contentStr = params[@"contentStr"];
    __alert.titleStr = params[@"titleStr"];
    __alert.cancelTitleStr = params[@"cancelTitleStr"];
    __alert.confirmTitleStr = params[@"confirmTitleStr"];
    
}

/**
 设置取消block
 
 @param params 取消block
 */
- (void)Action_setAlertCancelBlock:(NSDictionary *)params{
    __alert.cancelBlock = params[@"cancelBlock"];
}

/**
 设置确认block
 
 @param params 确认block
 */
- (void)Action_setAlertConfirmBlock:(NSDictionary *)params{
    __alert.confirmBlock = params[@"confirmBlock"];
}

@end
