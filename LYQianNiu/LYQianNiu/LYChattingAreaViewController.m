//
//  LYChattingAreaViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYChattingAreaViewController.h"
#import "HttpTool.h"
#import "NSImage+WebCache.h"

@interface LYChattingAreaViewController () <NSSplitViewDelegate, NSTableViewDelegate, NSTableViewDataSource,NSFetchedResultsControllerDelegate> {
    
    NSFetchedResultsController *_resultsContrller;
    
}
@property (weak) IBOutlet NSSplitView *splitView;//分割视图
@property (weak) IBOutlet NSTableView *chattingTableView;//聊天列表

@property (weak) IBOutlet NSBox *btnsBox;

@property (weak) IBOutlet NSButton *emojiBtn;//表情
@property (weak) IBOutlet NSButton *screenshotBtn;//截屏
@property (weak) IBOutlet NSButton *picTransferBtn;//图片
@property (weak) IBOutlet NSButton *sharkScreenBtn;//抖屏
@property (weak) IBOutlet NSButton *reportBtn;//举证
@property (weak) IBOutlet NSButton *quickReplyBtn;//快速回复
@property (weak) IBOutlet NSButton *chattingRecordBtn;//聊天记录

@property (nonatomic, strong) HttpTool *httpTool;

@end

@implementation LYChattingAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObjects];
    [self addNotification];
    
    [self refreshChattingMessage];
}

- (void) initObjects {
    self.chattingTableView.delegate = self;
    self.chattingTableView.dataSource = self;
}

#pragma mark - Notification

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshChattingMessage) name:LYContactRowSelectionDidChangeNotification object:nil];
}

- (void)refreshChattingMessage {
    //加载数据
    [self loadMessage];
    [self refershChattingTable];
}

- (void)refershChattingTable {
    [self.chattingTableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

#pragma mark - 加载XMPPMessageArchiving数据库的数据显示在tableview

- (void)loadMessage {
    //管理对象上下文
    NSManagedObjectContext *context = [LYXMPPTool sharedLYXMPPTool].msgStorage.mainThreadManagedObjectContext;//聊天的数据存储
    //请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];

    //过滤、排序
    //1 当前登录用户的JID的消息
    //2 好友的JID的消息
   
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@", [LYUserInfo sharedLYUserInfo].jid,  [LYChattingTool sharedLYChattingTool].currentChattingContactModel.jid.bare];
    request.predicate = predicate;
    //按时间升序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[timeSort];
    
    //查询
    _resultsContrller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    NSError *err = nil;
    
    //代理
    _resultsContrller.delegate = self;
    [_resultsContrller performFetch:&err];
    if (err) {
        LYLog(@"%@", err);
    
    }
}

- (HttpTool*) httpTool{
    if (!_httpTool) {
        _httpTool = [[HttpTool alloc] init];
    }
    return _httpTool;
}

#pragma mark - IBAction

- (IBAction)emojiBtnClicked:(id)sender {
}

- (IBAction)screenshotBtnClicked:(id)sender {
}

- (IBAction)picTransferBtnClicked:(id)sender {
}

- (IBAction)sharkScreenBtnClicked:(id)sender {
}

- (IBAction)reportBtnClicked:(id)sender {
}

- (IBAction)quickReplyBtnClicked:(id)sender {
}

- (IBAction)chattingRecordBtnClicked:(id)sender {
}


#pragma mark - NSSplitViewDelegate
//保持
-(void)splitView:(NSSplitView *)sender resizeSubviewsWithOldSize: (NSSize)oldSize {
    CGFloat dividerThickness = [sender dividerThickness];
    NSRect topRect = [[[sender subviews] objectAtIndex:0] frame];
    NSRect bottomRect = [[[sender subviews] objectAtIndex:1] frame];
    NSRect newFrame = [sender frame];
    
    topRect.size.width = newFrame.size.width;
    topRect.origin.y = bottomRect.size.height + dividerThickness;

    topRect.size.height = newFrame.size.height - bottomRect.size.height
    - dividerThickness;
    
    bottomRect.size.width = newFrame.size.width;
    bottomRect.origin = NSZeroPoint;
    [[[sender subviews] objectAtIndex:0] setFrame:topRect];
    [[[sender subviews] objectAtIndex:1] setFrame:bottomRect];
}

#pragma mark - NSTableViewDataSource & NSTableViewDelegate
#pragma mark - NSTableViewDelegate & NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _resultsContrller.fetchedObjects.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 40.0;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
//    NSUInteger selectRowIndex =  self.tableView.selectedRow;
//    XMPPUserCoreDataStorageObject *model = _dataSource[selectRowIndex];
//    [LYChattingTool sharedLYChattingTool].currentChattingContactModel = model;
//    [[NSNotificationCenter defaultCenter] postNotificationName:LYContactRowSelectionDidChangeNotification object:self];
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
//    LYTableRowView *rowView = [[LYTableRowView alloc] init];
//    return rowView;
    return nil;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = tableColumn.identifier;
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    if (!cellView) {
        cellView = [[NSTableCellView alloc]init];
        cellView.identifier = identifier;
    }
    
    XMPPMessageArchiving_Message_CoreDataObject *msg = _resultsContrller.fetchedObjects[row];
    
    if ([msg.outgoing boolValue]){//是往外发的，就是自己的
        cellView.textField.stringValue = [NSString stringWithFormat:@"Me:%@", msg.body];
    } else {//别人发的
        cellView.textField.stringValue = [NSString stringWithFormat:@"Other:%@", msg.body];
    }
    
    //判断是图片还是纯文本
//    NSString *chatType = [msg.message attributeStringValueForName:@"bodyType"];
//    if ([chatType isEqualToString:@"image"]) {
//        //下图片显示
//        //TODO 图片问题未解决
//        cellView.imageView = nil ;
//    } else if ([chatType isEqualToString:@"text"]) {
//        //显示消息
//        if ([msg.outgoing boolValue]){//是往外发的，就是自己的
//            cellView.textField.stringValue = [NSString stringWithFormat:@"Me:%@", msg.body];
//        } else {//别人发的
//            cellView.textField.stringValue = [NSString stringWithFormat:@"Other:%@", msg.body];
//        }
//        cellView.imageView.image = nil;
//    }
    return  cellView;

}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    //刷新数据
    [self.chattingTableView reloadData];
    
    [self scrollToTableBottom];
}

#pragma mark - Scroll

- (void)scrollToTableBottom {
    NSInteger lastRow = _resultsContrller.fetchedObjects.count - 1;
    if (lastRow < 0) {
        //行数若小于0，则不能滚动
        return;
    }
    [self.chattingTableView scrollRowToVisible:self.chattingTableView.numberOfRows-1];
}

@end
