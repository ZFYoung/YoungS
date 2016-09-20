//
//  FileEntity.h
//  YoungS
//
//  Created by ZFYoung on 15/9/28.
//  Copyright © 2015年 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileEntity : NSObject



@property (nonatomic,copy) NSString *fId;
@property (nonatomic,copy) NSString *fileName;
@property (nonatomic,copy) NSString *localPath;
@property (nonatomic,copy) NSString *remotePath;


-(id)initWithName:(NSString *)name local:(NSString *)local remote:(NSString *)remote;



@end
