//
//  ListController.h
//  YoungS
//
//  Created by ZFYoung on 15/9/29.
//  Copyright © 2015年 Young. All rights reserved.
//

#import "BaseController.h"

@interface FileListController : BaseController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *allFiles;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)btnPushClicked:(id)sender;

@end
