//
//  WZPAlertController.h
//  WZPAlertController
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//弹框内容类型
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
/** 标题文字 */
@property (nonatomic,  copy) NSString *titleStr;
/** 取消按钮文字 */
@property (nonatomic,  copy) NSString *cancelTitleStr;
/** 确认按钮文字 */
@property (nonatomic,  copy) NSString *confirmTitleStr;
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
/** 点击空白是否消失，默认消失 !tapBgCantCancel = true */
@property (nonatomic,assign) bool tapBgCantCancel;
/** 是否有取消按钮，默认取消和确认 !haveNotCancelBtn = true */
@property (nonatomic,assign) bool haveNotCancelBtn;

/** 相关点击事件的block */
typedef void(^WZPAlertCancel)(id date);
typedef void(^WZPAlertConfirm)(id date);
@property (nonatomic,  copy) WZPAlertCancel cancelBlock;
@property (nonatomic,  copy) WZPAlertConfirm confirmBlock;


@end
