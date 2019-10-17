//
//  ViewController.m
//  WZPAlertController
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ViewController.h"
#import "WZPAlertController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)testBtnClick:(UIButton *)sender {
    WZPAlertController *alert = [[WZPAlertController alloc]init];
    alert.contentType = WZPAlertControllerContentTypeWeb;
    alert.contentStr = @"https://www.baidu.com/";//@"-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg-----https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1139292180,1402602244&fm=26&gp=0.jpg";//@"http://image-7.verycd.com/1252bda8b6676e80179cfbe06354ac07158248%28600x%29/thumb.jpg";
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
