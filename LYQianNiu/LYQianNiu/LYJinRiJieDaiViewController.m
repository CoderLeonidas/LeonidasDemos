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

@interface LYJinRiJieDaiViewController () <NSTableViewDelegate, NSTableViewDataSource, NSFetchedResultsControllerDelegate> {

    NSMutableArray  *_dataSource;
    NSFetchedResultsController *_resultsContrl;
}
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation LYJinRiJieDaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObjects];
    [self loadRoster2];
}

- (void)initObjects {
    _dataSource = [NSMutableArray array];
}

#pragma mark - Contact

- (void)loadRoster1 {
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
    
    //4 执行请求获取数据 使用NSManagedObjectContext
    NSError *error = nil;
    NSArray *arr = [context executeFetchRequest:request error:&error];
    _dataSource = [NSMutableArray arrayWithArray:arr];
    if (error) {
        LYLog(@"loadRoster: %@", error);
    }
}


- (void)loadRoster2 {
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
    
    //4 执行请求获取数据 使用NSFetchedResultsController
    _resultsContrl = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _resultsContrl.delegate = self;
    NSError *error = nil;
    [_resultsContrl performFetch:&error];
    NSArray *arr = _resultsContrl.fetchedObjects;
    _dataSource = [NSMutableArray arrayWithArray:arr];
    if (error) {
        LYLog(@"loadRoster: %@", error);
    }
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    LYLog(@"CoreData数据发生变化");
    NSArray *arr = _resultsContrl.fetchedObjects;
    _dataSource = [NSMutableArray arrayWithArray:arr];
    
    NSUInteger selectRowIndex =  self.tableView.selectedRow;
    XMPPUserCoreDataStorageObject *model = _dataSource[selectRowIndex];
    [LYChattingTool sharedLYChattingTool].currentChattingContactModel = model;//更新当前的联系人model
    [self.tableView reloadData];
}

#pragma mark - NSTableViewDelegate & NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _dataSource.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 40.0;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSUInteger selectRowIndex =  self.tableView.selectedRow;
    XMPPUserCoreDataStorageObject *model = _dataSource[selectRowIndex];
    [LYChattingTool sharedLYChattingTool].currentChattingContactModel = model;
    [[NSNotificationCenter defaultCenter] postNotificationName:LYContactRowSelectionDidChangeNotification object:self];
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    LYTableRowView *rowView = [[LYTableRowView alloc] init];
    return rowView;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = NSStringFromClass([LYContactTableCellView class]);
    if (!identifier) return nil;
    
    LYContactTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    if (!cellView) {
        cellView = [LYContactTableCellView contactTableCellView];
        cellView.identifier = identifier;
    }
    cellView.model = nil;
    XMPPUserCoreDataStorageObject *model = _dataSource[row];
    if (![model isKindOfClass:[XMPPUserCoreDataStorageObject class]]) {
        return nil;
    }
    cellView.model = model;
        
    return cellView;
}

@end
