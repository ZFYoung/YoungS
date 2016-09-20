//
//  DownLoadManager.h
//  YoungS
//
//  Created by ZFYoung on 15/9/28.
//  Copyright © 2015年 Young. All rights reserved.
//

#import "BaseManager.h"
#import "AFNetworking.h"
#import "DBManager.h"

@interface DownLoadManager : BaseManager

- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag;

@end
