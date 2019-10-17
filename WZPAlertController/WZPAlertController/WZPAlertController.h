//
//  WZPAlertController.h
//  WZPAlertController
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WZPAlertControllerContentType)
{
    WZPAlertControllerContentTypeText = 0,  //文字
    WZPAlertControllerContentTypeImage,     //图片
    WZPAlertControllerContentTypeWeb,       //web页面
};

@interface WZPAlertController : UIViewController

/** 提示内容的类型 */
@property (nonatomic,assign) WZPAlertControllerContentType contentType;
/** 内容 */
@property (nonatomic,  copy) NSString *contentStr;
/** 标题字体颜色 */
@property (nonatomic,strong) UIColor *titleFontColor;
/** 标题背景颜色 */
@property (nonatomic,strong) UIColor *titleBgColor;
/** 内容字体颜色 */
@property (nonatomic,strong) UIColor *contentFontColor;
/** 取消按钮字体颜色 */
@property (nonatomic,strong) UIColor *cancelBtnFontColor;
/** 取消按钮背景颜色 */
@property (nonatomic,strong) UIColor *cancelBtnBgColor;
/** 确认按钮字体颜色 */
@property (nonatomic,strong) UIColor *confirmBtnFontColor;
/** 确认按钮背景颜色 */
@property (nonatomic,strong) UIColor *confirmBtnBgColor;
/** 点击空白是否消失，默认 消失yes */
@property (nonatomic,assign) bool tapBgCancel;

@end