//
//  DBManager.h
//  YoungS
//
//  Created by ZFYoung on 15/9/28.
//  Copyright © 2015年 Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileEntity.h"

@interface DBManager : NSObject



+ (DBManager *)shareInstance;

#pragma mark ----  用户/好友存储

//存储文件信息
-(void)insertFileToDB:(FileEntity *)file;

//移除文件
- (void)removeFileFromDB:(NSString *)fId;

//从表中获取用户信息
-(FileEntity *) getFileByFileId:(NSString *)fId;

//从表中获取所有用户信息
-(NSArray *) getAllFileInfoList;



@end
