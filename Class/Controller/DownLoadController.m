//
//  DownLoadController.m
//  YoungS
//
//  Created by ZFYoung on 15/9/28.
//  Copyright © 2015年 Young. All rights reserved.
//

#import "DownLoadController.h"
#import "DownLoadManager.h"

@interface DownLoadController ()

@end

@implementation DownLoadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!dManager) {
        dManager = [[DownLoadManager alloc]init];
    }
}


- (IBAction)btnDownClicked:(id)sender {
    if (_txtUrl.text.length<=0) {
        [self showAlertView:@"请输入下载链接"];
        return;
    }
    
    NSString *lastcom = [_txtUrl.text lastPathComponent];
    
    NSString *multiPath = NSHomeDirectory();
    multiPath = [NSString stringWithFormat:@"%@/Document/downloadData/",multiPath];
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:multiPath]){
        [fm createDirectoryAtPath:multiPath
      withIntermediateDirectories:YES
                       attributes:nil
                            error:nil];
    }
    
    
    [dManager downloadFileURL:_txtUrl.text savePath:multiPath fileName:lastcom tag:0];
    
    
}

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
