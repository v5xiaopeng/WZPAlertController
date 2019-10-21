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

@interface WZPAlertController ()<UIGestureRecognizerDelegate,WKUIDelegate,WKNavigationDelegate>{
    //  弹框view背景
    UIView *_alertBgView;
    //  标题
    UILabel *_titleLb;
    //  内容背景
    UIView *_contentBgView;
    //  text文字内容
    UILabel *_contentLb;
    //  取消按钮
    UIButton *_cancelBtn;
    //  确认按钮
    UIButton *_confirmBtn;
    //  web内容webView
    WKWebView *_contentWebView;
    //  web加载进度条
    UIProgressView *_webProgressView;
}

@end

@implementation WZPAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    //  弹框背景点击手势
    UITapGestureRecognizer *bgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewSingleTap)];
    bgViewTap.delegate = self;
    bgViewTap.numberOfTapsRequired = 1;
    bgViewTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:bgViewTap];
    
    [self initSomeColor];
    [self loadSomeView];
    
}

//  点击事件代理方法，弹框view背景不响应点击事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    CGPoint touchP = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_alertBgView.frame, touchP)) {
        return NO;
    }

    return YES;
}

//  点击事件
- (void)bgViewSingleTap{
    if (!self.tapBgCantCancel) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - ---一些颜色的set方法、页面初始化---
//  初始化默认颜色
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

//  初始化alertView
- (void)loadSomeView{
    //  背景
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
    //  标题
    _titleLb = [[UILabel alloc]init];
    _titleLb.text = ([self.titleStr isEqualToString:@""] || self.titleStr == nil) ? @"标题" : self.titleStr;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.font = [UIFont systemFontOfSize:20];
    _titleLb.textColor = self.titleFontColor;
    _titleLb.backgroundColor = self.titleBgColor;
    [_alertBgView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self->_alertBgView);
        make.height.mas_equalTo(50);
    }];
    //  取消/确认按钮
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:([self.cancelTitleStr isEqualToString:@""] || self.cancelTitleStr == nil) ? @"取消" : self.cancelTitleStr forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:self.cancelBtnFontColor forState:UIControlStateNormal];
    _cancelBtn.backgroundColor = self.cancelBtnBgColor;
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancelBtn addTarget:self action:@selector(alertCancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:([self.confirmTitleStr isEqualToString:@""] || self.confirmTitleStr == nil) ? @"确认" : self.confirmTitleStr forState:UIControlStateNormal];
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
    //  内容
    _contentBgView = [[UIView alloc]init];
    _contentBgView.backgroundColor = [UIColor whiteColor];
    [_alertBgView addSubview:_contentBgView];
    [_contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_titleLb.mas_bottom);
        make.left.right.equalTo(self->_alertBgView);
        make.bottom.equalTo(self->_confirmBtn.mas_top);
    }];
    [self loadContentView];
}

//  根据类型初始化三种类型的内容
- (void)loadContentView{
    if (self.contentType == WZPAlertControllerContentTypeImage) {
        //  image图片类型的内容
        UIImageView *contentImageView = [[UIImageView alloc]init];
        [_contentBgView addSubview:contentImageView];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.contentStr] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            //  图片下载完刷新imageView
            if (image && finished) {
                CGFloat imageHeight = image.size.height;
                CGFloat imageWidth = image.size.width;
                CGFloat scaleImageHeight = (kSCREEN_WIDTH-50)*imageHeight/imageWidth;
                CGFloat scaleImageWidth = kSCREEN_WIDTH-50;
                //  图片高度超高，imageView按照弹框上下留边25，俺最大高度等比缩放
                if (scaleImageHeight > kSCREEN_HEIGHT-144) {
                    scaleImageHeight = kSCREEN_HEIGHT-144;
                    scaleImageWidth = (kSCREEN_HEIGHT-144)*imageWidth/imageHeight;
                }
                //  主线程刷新相关控件宽高
                dispatch_async(dispatch_get_main_queue(), ^{
                    contentImageView.image = image;
                    [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.center.equalTo(self->_contentBgView);
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
        //  web类型的内容
        _contentWebView = [[WKWebView alloc]init];
//        _contentWebView.UIDelegate = self;
//        _contentWebView.navigationDelegate = self;
        [_contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.contentStr]]];
        [_contentBgView addSubview:_contentWebView];
        [_contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self->_contentBgView);
            make.height.mas_equalTo(kSCREEN_HEIGHT/2.0);
        }];
        _webProgressView = [[UIProgressView alloc]init];
        _webProgressView.progressViewStyle = UIProgressViewStyleBar;
        _webProgressView.progressTintColor = self.titleFontColor;
        _webProgressView.trackTintColor = [UIColor clearColor];
        [_webProgressView setProgress:0.1 animated:YES];
        [_contentBgView addSubview:_webProgressView];
        [_webProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self->_contentBgView);
            make.height.mas_equalTo(2);
        }];
        //  KVO webView加载进度
        [_contentWebView addObserver:self
                          forKeyPath:@"estimatedProgress"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
    }else{
        //  text类型的内容
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

//  KVO 监听web加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _contentWebView) {
//        NSLog(@"网页加载进度 = %f",_contentWebView.estimatedProgress);
        _webProgressView.progress = _contentWebView.estimatedProgress;
        if (_contentWebView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self->_webProgressView.progress = 0;
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

#pragma mark - ---预留web交互---
#pragma mark WKNavigationDelegate

//  页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}

//  页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [_webProgressView setProgress:0.0f animated:NO];
}

//  当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}

//  页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
}

//  提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [_webProgressView setProgress:0.0f animated:NO];
}

//  接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
}

//  根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"发送跳转请求：%@",urlStr);
    //自己定义的协议头
    NSString *htmlHeadString = @"github://";
    if([urlStr hasPrefix:htmlHeadString]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通过截取URL调用OC" message:@"你想前往我的Github主页?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@"github://callName_?" withString:@""]];
            [[UIApplication sharedApplication] openURL:url];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
//  根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

#pragma mark WKUIDelegate
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

//  确认框
//  JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

//  输入框
//  JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

//  页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - ---取消/确认按钮 action And block---
- (void)alertCancelButtonClick{
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
    if (self.confirmBlock) {
        self.confirmBlock(nil);
    }
}

- (void)setConfirmBlock:(WZPAlertConfirm)confirmBlock{
    _confirmBlock = confirmBlock;
}

- (void)dealloc{
    //  移除观察者
    [_contentWebView removeObserver:self
                         forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
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
