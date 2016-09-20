//
//  DBManager.m
//  YoungS
//
//  Created by ZFYoung on 15/9/28.
//  Copyright © 2015年 Young. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "DBHelper.h"

@implementation DBManager


static NSString * const fileTableName = @"FILETABLE";



+ (DBManager *)shareInstance
{
    static DBManager* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        [instance CreateFileTable];
    });
    return instance;
}



#pragma mark ----  用户/好友存储

-(void)CreateFileTable
{
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    if (queue==nil) {
        return;
    }
    [queue inDatabase:^(FMDatabase *db) {
        if (![DBHelper isTableOK: fileTableName withDB:db]) {
            NSString *createTableSQL = @"CREATE TABLE FILETABLE (id integer PRIMARY KEY autoincrement, fId text,fName text, remoteUrl text, localPath text)";
            [db executeUpdate:createTableSQL];
            NSString *createIndexSQL=@"CREATE unique INDEX idx_fId ON FILETABLE(fId);";
            [db executeUpdate:createIndexSQL];
        }
    }];
    
}


//存储文件信息
-(void)insertFileToDB:(FileEntity *)file{
    NSString *insertSql = @"REPLACE INTO FILETABLE (fId, fName, remoteUrl, localPath) VALUES (?, ?, ?, ?)";
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql,file.fId,file.fileName,file.remotePath,file.localPath];
    }];
}

//移除文件
- (void)removeFileFromDB:(NSString *)fId{
    NSString *deleteSql =[NSString stringWithFormat: @"DELETE FROM FILETABLE WHERE fId = '%@'",fId];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    if (queue==nil) {
        return ;
    }
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];
    }];
}

//从表中获取用户信息
-(FileEntity *) getFileByFileId:(NSString *)fId{
    __block FileEntity  *model = nil;
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    if (queue==nil) {
        return nil;
    }
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM FILETABLE where fId = ?",fId];
        while ([rs next]) {
            model = [[FileEntity  alloc] init];
            model.fId = [rs stringForColumn:@"fId"];
            model.fileName = [rs stringForColumn:@"fName"];
            model.remotePath = [rs stringForColumn:@"remoteUrl"];
            model.localPath = [rs stringForColumn:@"localPath"];
        }
        [rs close];
    }];
    return model;
}

//从表中获取所有用户信息
-(NSArray *) getAllFileInfoList{
    
    NSMutableArray *allFiles = [NSMutableArray new];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM FILETABLE"];
        while ([rs next]) {
            FileEntity  *model;
            model = [[FileEntity  alloc] init];
            model.fId = [rs stringForColumn:@"fId"];
            model.fileName = [rs stringForColumn:@"fName"];
            model.remotePath = [rs stringForColumn:@"remoteUrl"];
            model.localPath = [rs stringForColumn:@"localPath"];
            [allFiles addObject:model];
        }
        [rs close];
    }];
    return allFiles;
}










@end
