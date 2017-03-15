//
//  LYChattingAreaViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYChattingAreaViewController.h"

@interface LYChattingAreaViewController () <NSSplitViewDelegate, NSTableViewDelegate, NSTableViewDataSource>
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


@end

@implementation LYChattingAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
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
//    return _dataSource.count;
    return 100;
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
//    if (!identifier)
    
        return nil;
    
//    LYContactTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
//    if (!cellView) {
//        cellView = [LYContactTableCellView contactTableCellView];
//    }
//    XMPPUserCoreDataStorageObject *model = _dataSource[row];
//    if (![model isKindOfClass:[XMPPUserCoreDataStorageObject class]]) {
//        return nil;
//    }
//    cellView.model = model;
//    return cellView;
}
@end
