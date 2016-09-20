//
//  FileEntity.m
//  YoungS
//
//  Created by ZFYoung on 15/9/28.
//  Copyright © 2015年 Young. All rights reserved.
//

#import "FileEntity.h"

@implementation FileEntity

-(id)init{
    self = [super init];
    if (self) {
        
        [self initNil];
    }
    
    return self;
}

-(void)initNil{
    
    _fId = @"";
    _fileName = @"";
    _localPath = @"";
    _remotePath = @"";
}


-(id)initWithName:(NSString *)name local:(NSString *)local remote:(NSString *)remote{
    
    [self initNil];
    
    _fileName = name;
    _remotePath = remote;
    _localPath = local;

    return self;
}


@end
