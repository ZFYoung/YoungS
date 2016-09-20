//
//  BaseManager.m
//  YoungS
//
//  Created by ZFYoung on 15/9/28.
//  Copyright © 2015年 Young. All rights reserved.
//

#import "BaseManager.h"
#import <UIKit/UIKit.h>

@implementation BaseManager



-(void)showAlertView:(NSString *)tip{
    
    UIAlertView *_alt = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [_alt show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_alt dismissWithClickedButtonIndex:0 animated:YES];
    });
}



@end
