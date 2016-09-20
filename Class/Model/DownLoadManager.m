//
//  DownLoadManager.m
//  YoungS
//
//  Created by ZFYoung on 15/9/28.
//  Copyright © 2015年 Young. All rights reserved.
//

#import "DownLoadManager.h"

@implementation DownLoadManager


/**
 * 下载文件
 */
- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@%@", aSavePath, aFileName];
    
    //检查附件是否存在
    if ([fileManager fileExistsAtPath:fileName]) {
        [self showAlertView:@"文件已经存在"];
    }else{
        //创建附件存储目录
        if (![fileManager fileExistsAtPath:aSavePath]) {
            [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        //下载附件
        NSURL *url = [[NSURL alloc] initWithString:aUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.inputStream   = [NSInputStream inputStreamWithURL:url];
        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
        
        //下载进度控制
        
         [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
         NSLog(@"is download：%f", (float)totalBytesRead/totalBytesExpectedToRead);
         }];
        
        
        //已完成下载
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

            FileEntity *file = [[FileEntity alloc] initWithName:aFileName local:fileName remote:aUrl];
            file.fId = [self curTimeinterval];
            
            [[DBManager shareInstance]insertFileToDB:file];
            
            [self showAlertView:@"下载成功"];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //下载失败
            [self showAlertView:@"下载失败"];
            
            NSFileManager *fm = [[NSFileManager alloc] init];
            [fm removeItemAtURL:[NSURL URLWithString:fileName] error:nil];
            
            
        }];
        
        [operation start];
    }
}


- (NSString *) curTimeinterval {
    NSDate *date = [NSDate date];
    NSTimeInterval ti = [date timeIntervalSince1970];
    
    NSString *str = [NSString stringWithFormat:@"%.0f",ti];
    return str;
}

@end
