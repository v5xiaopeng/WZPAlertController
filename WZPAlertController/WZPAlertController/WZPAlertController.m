//
//  WZPAlertController.m
//  WZPAlertController
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "WZPAlertController.h"
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import <WebKit/WebKit.h>

#define kSCREEN_WIDTH       ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT      ([UIScreen mainScreen].bounds.size.height)
#define kCOLORRGB(r,g,b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kIphone6Scale(x)    ((x) * kSCREEN_WIDTH / 375.0f)
@interface WZPAlertController ()<UIGestureRecognizerDelegate>{
    UIView *_alertBgView;
    UILabel *_titleLb;
    UIView *_contentBgView;
    UILabel *_contentLb;
    UIButton *_cancelBtn;
    UIButton *_confirmBtn;
}

@end

@implementation WZPAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    UITapGestureRecognizer *bgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewSingleTap)];
    bgViewTap.delegate = self;
    bgViewTap.numberOfTapsRequired = 1;
    bgViewTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:bgViewTap];
    
    [self initSomeColor];
    [self loadSomeView];
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint touchP = [touch locationInView:self.view];
    if (CGRectContainsPoint(_alertBgView.frame, touchP)) {
        return NO;
    }

    return YES;
}
- (void)bgViewSingleTap{
    if (!self.tapBgCantCancel) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
//默认颜色
- (void)initSomeColor{
    self.titleFontColor = self.titleFontColor != nil ? self.titleFontColor : [UIColor blackColor];
    self.titleBgColor = self.titleBgColor != nil ? self.titleBgColor : [UIColor whiteColor];
    self.contentFontColor = self.contentFontColor != nil ? self.contentFontColor : [UIColor blackColor];
    self.cancelBtnFontColor = self.cancelBtnFontColor != nil ? self.cancelBtnFontColor : [UIColor blackColor];
    self.cancelBtnBgColor = self.cancelBtnBgColor != nil ? self.cancelBtnBgColor : [UIColor whiteColor];
    self.confirmBtnFontColor = self.confirmBtnFontColor != nil ? self.confirmBtnFontColor : [UIColor whiteColor];
    self.confirmBtnBgColor = self.confirmBtnBgColor != nil ? self.confirmBtnBgColor : [UIColor greenColor];
}
- (void)setTitleFontColor:(UIColor *)titleFontColor{
    _titleFontColor = titleFontColor;
    _titleLb.textColor = _titleFontColor;
}
- (void)setTitleBgColor:(UIColor *)titleBgColor{
    _titleBgColor = titleBgColor;
    _titleLb.backgroundColor = _titleBgColor;
}
- (void)setContentFontColor:(UIColor *)contentFontColor{
    _contentFontColor = contentFontColor;
    _contentLb.textColor = _contentFontColor;
}
- (void)setCancelBtnFontColor:(UIColor *)cancelBtnFontColor{
    _cancelBtnFontColor = cancelBtnFontColor;
    [_cancelBtn setTitleColor:_cancelBtnFontColor forState:UIControlStateNormal];
}
- (void)setCancelBtnBgColor:(UIColor *)cancelBtnBgColor{
    _cancelBtnBgColor = cancelBtnBgColor;
    _cancelBtn.backgroundColor = _cancelBtnBgColor;
}
- (void)setConfirmBtnFontColor:(UIColor *)confirmBtnFontColor{
    _confirmBtnFontColor = confirmBtnFontColor;
    [_confirmBtn setTitleColor:_confirmBtnFontColor forState:UIControlStateNormal];
}
- (void)setConfirmBtnBgColor:(UIColor *)confirmBtnBgColor{
    _confirmBtnBgColor = confirmBtnBgColor;
    _confirmBtn.backgroundColor = _confirmBtnBgColor;
}
- (void)loadSomeView{
    _alertBgView = [[UIView alloc]init];
    _alertBgView.backgroundColor = [UIColor whiteColor];
    _alertBgView.layer.cornerRadius = 5.0;
    _alertBgView.clipsToBounds = YES;
    [self.view addSubview:_alertBgView];
    [_alertBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.centerY.equalTo(self.view);
        make.height.mas_lessThanOrEqualTo(kSCREEN_HEIGHT-50);
    }];
//    _alertBgView.frame = CGRectMake(25, (kSCREEN_HEIGHT-300)/2.0, kSCREEN_WIDTH-50, 300);
    //标题
    _titleLb = [[UILabel alloc]init];
    _titleLb.text = @"标题";
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.font = [UIFont systemFontOfSize:20];
    _titleLb.textColor = self.titleFontColor;
    _titleLb.backgroundColor = self.titleBgColor;
    [_alertBgView addSubview:_titleLb];
//    _titleLb.frame = CGRectMake(0, 0, _alertBgView.frame.size.width, 50);
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self->_alertBgView);
        make.height.mas_equalTo(50);
    }];
    //按钮
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:self.cancelBtnFontColor forState:UIControlStateNormal];
    _cancelBtn.backgroundColor = self.cancelBtnBgColor;
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancelBtn addTarget:self action:@selector(alertCancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    _cancelBtn.frame = CGRectMake(0, _alertBgView.frame.size.height-44, _alertBgView.frame.size.width/2.0, 44);
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:self.confirmBtnFontColor forState:UIControlStateNormal];
    _confirmBtn.backgroundColor = self.confirmBtnBgColor;
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_confirmBtn addTarget:self action:@selector(alertConfirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertBgView addSubview:_confirmBtn];
    if (!self.haveNotCancelBtn) {
        [_alertBgView addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_alertBgView);
            make.right.equalTo(self->_alertBgView.mas_centerX);
            make.bottom.equalTo(self->_alertBgView);
            make.height.mas_equalTo(44);
        }];
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_alertBgView.mas_centerX);
            make.right.equalTo(self->_alertBgView);
            make.bottom.equalTo(self->_alertBgView);
            make.height.mas_equalTo(44);
        }];
    }else{
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_alertBgView);
            make.right.equalTo(self->_alertBgView);
            make.bottom.equalTo(self->_alertBgView);
            make.height.mas_equalTo(44);
        }];
    }
//    _confirmBtn.frame = CGRectMake(_alertBgView.frame.size.width/2.0, _alertBgView.frame.size.height-44, _alertBgView.frame.size.width/2.0, 44);
    //内容
    _contentBgView = [[UIView alloc]init];
    _contentBgView.backgroundColor = [UIColor whiteColor];
    [_alertBgView addSubview:_contentBgView];
//    _contentBgView.frame = CGRectMake(0, 50, _alertBgView.frame.size.width, _alertBgView.frame.size.height-50-44);
    [_contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_titleLb.mas_bottom);
        make.left.right.equalTo(self->_alertBgView);
        make.bottom.equalTo(self->_confirmBtn.mas_top);
    }];
    [self loadContentView];
}
- (void)loadContentView{
    if (self.contentType == WZPAlertControllerContentTypeImage) {
        UIImageView *contentImageView = [[UIImageView alloc]init];
        [_contentBgView addSubview:contentImageView];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.contentStr] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            //            UIImage *image = [UIImage imageNamed:@"testImg03.jpg"];
            if (image && finished) {
                CGFloat imageHeight = image.size.height;
                CGFloat imageWidth = image.size.width;
                CGFloat scaleImageHeight = (kSCREEN_WIDTH-50)*imageHeight/imageWidth;
                CGFloat scaleImageWidth = kSCREEN_WIDTH-50;
                if (scaleImageHeight > kSCREEN_HEIGHT-144) {
                    scaleImageHeight = kSCREEN_HEIGHT-144;
                    scaleImageWidth = (kSCREEN_HEIGHT-144)*imageWidth/imageHeight;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    contentImageView.image = image;
                    [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.center.equalTo(self->_contentBgView);
                        //            make.top.left.bottom.right.equalTo(self->_contentBgView);
                        make.width.mas_equalTo(scaleImageWidth);
                        make.height.mas_equalTo(scaleImageHeight);
                    }];
                    [self->_contentBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(scaleImageHeight);
                    }];
                    [self->_alertBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_lessThanOrEqualTo(kSCREEN_HEIGHT-50);
                    }];
                });
                
            }
        }];
    }else if (self.contentType == WZPAlertControllerContentTypeWeb) {
        WKWebView *contentWebView = [[WKWebView alloc]init];
        
        [contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.contentStr]]];
        [_contentBgView addSubview:contentWebView];
        [contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self->_contentBgView);
            make.height.mas_equalTo(kSCREEN_HEIGHT/2.0);
        }];
    }else{
        _contentLb = [[UILabel alloc]init];
        _contentLb.text = self.contentStr;
        _contentLb.textColor = self.contentFontColor;
        _contentLb.numberOfLines = 0;
        _contentLb.font = [UIFont systemFontOfSize:15];
        [_contentBgView addSubview:_contentLb];
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_contentBgView);
            make.left.mas_equalTo(15);
            make.bottom.equalTo(self->_contentBgView);
            make.right.mas_equalTo(-15);
        }];
    }
}
- (void)alertCancelButtonClick{
    NSLog(@"取消");
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.cancelBlock) {
            self.cancelBlock(nil);
        }
    }];
}
- (void)setCancelBlock:(WZPAlertCancel)cancelBlock{
    _cancelBlock = cancelBlock;
}
- (void)alertConfirmButtonClick{
    NSLog(@"确认");
    if (self.confirmBlock) {
        self.confirmBlock(nil);
    }
}
- (void)setConfirmBlock:(WZPAlertConfirm)confirmBlock{
    _confirmBlock = confirmBlock;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
