//
//  LYJinRiJieDaiViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/9.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYJinRiJieDaiViewController.h"
#import "LYContactTableCellView.h"
#import "LYContactModel.h"
#import "LYTableRowView.h"


@interface LYLianXiRenEntity: NSObject

@end

@interface LYJinRiJieDaiViewController () <NSTableViewDelegate, NSTableViewDataSource> {

    NSMutableArray *_dataSource;
}

@end

@implementation LYJinRiJieDaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObjects];
    [self testDataSource];
//    [self loadRoster];
}

- (void)initObjects {
    _dataSource = [NSMutableArray array];
}

- (void)testDataSource {
    for (int i=0;i<30;i++){
        LYContactModel *model = [[LYContactModel alloc] init];
        model.shopName = @"Leon的街角咖啡";
        model.shopAssistantName = @"Leon的女盆友";
        model.shopAvatarName = @"LeonCafe";
        [_dataSource addObject:model];
    }
}

#pragma mark - Contact

- (void)loadRoster {
    //使用CoreData获取数据
    //1 上下文【关联数据库 XMPPRoster.sqlite】
    NSManagedObjectContext *context = [LYXMPPTool sharedLYXMPPTool].rosterStorage.mainThreadManagedObjectContext;
    //2 FetchRequest 查哪张表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    //3 设置过滤条件
    //过滤当前登录用户的好友
    NSString *jid = [LYUserInfo sharedLYUserInfo].jid;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@", jid];
    request.predicate = predicate;
    
    //排序
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    
    //4 执行请求获取数据
    NSError *error = nil;
    NSArray *arr = [context executeFetchRequest:request error:&error];
    _dataSource = [NSMutableArray arrayWithArray:arr];
    if (error) {
        LYLog(@"loadRoster: %@", error);
    }
}

#pragma mark - NSTableViewDelegate & NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _dataSource.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 40.0;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {

}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    LYTableRowView *rowView = [[LYTableRowView alloc] init];
    return rowView;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = tableColumn.identifier;
    if (!identifier) return nil;
    
    LYContactTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    if (!cellView) {
        cellView = [LYContactTableCellView contactTableCellView];
    }
    LYContactModel *model = _dataSource[row];
    model.shopAssistantName = [NSString stringWithFormat:@"%@%ld",model.shopAssistantName,row];
    cellView.model = model;
    return cellView;
}

@end
