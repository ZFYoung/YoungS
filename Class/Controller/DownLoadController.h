//
//  DownLoadController.h
//  YoungS
//
//  Created by ZFYoung on 15/9/28.
//  Copyright © 2015年 Young. All rights reserved.
//

#import "BaseController.h"
#import "DownLoadManager.h"

@interface DownLoadController : BaseController{
    DownLoadManager *dManager;
}


@property (weak, nonatomic) IBOutlet UITextField *txtUrl;


- (IBAction)btnDownClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;

@end
