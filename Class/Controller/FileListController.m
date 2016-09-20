//
//  ListController.m
//  YoungS
//
//  Created by ZFYoung on 15/9/29.
//  Copyright © 2015年 Young. All rights reserved.
//

#import "FileListController.h"
#import "DBManager.h"
#import "MediaPlayController.h"

@interface FileListController ()

@end

@implementation FileListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!allFiles) {
        allFiles = [NSMutableArray array];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getAllFileList];
}


-(void)getAllFileList{
    [allFiles removeAllObjects];
    NSArray *list = [[DBManager shareInstance]getAllFileInfoList];
    [allFiles addObjectsFromArray:list];
}


#pragma mark -- UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return allFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    FileEntity *file = [allFiles objectAtIndex:indexPath.row];
    
    cell.textLabel.text = file.fileName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MediaPlayController *vc = [sb instantiateViewControllerWithIdentifier:@"mediaPlayVCID"];
    FileEntity *file = [allFiles objectAtIndex:indexPath.row];
    vc.localPath = file.localPath;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;  //返回此值时,Cell会做出响应显示Delete按键
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        if (indexPath.row<[allFiles count]) {
            
            
            FileEntity *file = [allFiles objectAtIndex:indexPath.row];
            
            
            [[DBManager shareInstance]removeFileFromDB:file.fId];
            NSFileManager *fm = [[NSFileManager alloc] init];
            [fm removeItemAtURL:[NSURL URLWithString:file.localPath] error:nil];
            
            
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
            
        }
    }
}


- (IBAction)btnPushClicked:(id)sender {
    [self performSegueWithIdentifier:@"gotoDownload" sender:self];
}

@end
