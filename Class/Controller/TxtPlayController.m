//
//  TxtPlayController.m
//  YoungS
//
//  Created by ZFYoung on 15/9/30.
//  Copyright © 2015年 Young. All rights reserved.
//

#import "TxtPlayController.h"

@interface TxtPlayController ()

@end

@implementation TxtPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT-64)];
        [self.view addSubview:_webView];
    }
}


-(void)loadBaseInfo:(NSString *)path{
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];

}


@end
