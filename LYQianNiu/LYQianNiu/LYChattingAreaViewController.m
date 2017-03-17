//
//  LYChattingAreaViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYChattingAreaViewController.h"
#import "LYHttpTool.h"
#import "NSImage+WebCache.h"
#import "LYChattingCell.h"
@interface LYChattingAreaViewController () <NSSplitViewDelegate, NSTableViewDelegate, NSTableViewDataSource,NSFetchedResultsControllerDelegate, NSTextViewDelegate> {
    
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
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@property (nonatomic, strong) LYHttpTool *httpTool;

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
    self.textView.delegate = self;
}

#pragma mark - Notification

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshChattingMessage) name:LYContactRowSelectionDidChangeNotification object:nil];
}

- (void)refreshChattingMessage {
    //加载数据
    [self loadMessage];
    [self refershChattingTable];
    [self scrollToTableBottom];
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
    //请求对象, EntityName就是表名
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];

    //过滤、排序
    //1 当前登录用户的JID的消息
    //2 好友的JID的消息
   
    NSString *crurrentContactBare = [LYChattingTool sharedLYChattingTool].currentChattingContactModel.jid.bare;
    LYLog(@"crurrentContactBaren = %@", crurrentContactBare);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@", [LYUserInfo sharedLYUserInfo].jid,  crurrentContactBare];
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

- (LYHttpTool*) httpTool{
    if (!_httpTool) {
        _httpTool = [[LYHttpTool alloc] init];
    }
    return _httpTool;
}

#pragma mark - IBAction

- (IBAction)emojiBtnClicked:(id)sender {
}

- (IBAction)screenshotBtnClicked:(id)sender {
}

- (IBAction)picTransferBtnClicked:(id)sender {
    //打开文件选择面板
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.canChooseFiles = YES;
    openPanel.canChooseDirectories = NO;
    openPanel.allowsMultipleSelection = NO;
    openPanel.allowedFileTypes = @[@"jpeg", @"tiff", @"gif", @"png", @"bmp"];
    [openPanel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton ) {
            NSArray *fileURLs = [openPanel URLs];
            for (NSURL *url in fileURLs) {//不能多选，所以只有一次循环
                NSString *imageName = url.path.lastPathComponent;
                [self showImage:imageName toTextView:self.textView];
            }
        }
    }];
}

//将图片以属性文字的形式显示在textview上(支持图文混排)
- (void)showImage:(NSString *)imageName toTextView:(NSTextView *)textView {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    NSFileWrapper *imageFileWrapper = [[NSFileWrapper alloc] initRegularFileWithContents:[[NSImage imageNamed:imageName] TIFFRepresentation]];
    imageFileWrapper.filename = imageName;
    imageFileWrapper.preferredFilename = imageName;
    NSTextAttachment *imageAttachment = [[NSTextAttachment alloc] initWithFileWrapper:imageFileWrapper] ;
    NSAttributedString *imageAttributedString = [NSAttributedString attributedStringWithAttachment:imageAttachment];
    [attributedString insertAttributedString:imageAttributedString atIndex:0];
    [textView insertText:attributedString];
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

#pragma mark - NSTableViewDelegate & NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSUInteger num = _resultsContrller.fetchedObjects.count;
    return num;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 165.0;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = tableColumn.identifier;
    LYChattingCell *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    if (!cellView) {
        cellView = [[LYChattingCell alloc]init];
        cellView.identifier = identifier;
    }
    cellView.avatarBtn.image = nil;
    cellView.contentTextView.string = @"";
    cellView.timeLbl.stringValue = @"";
    
    XMPPMessageArchiving_Message_CoreDataObject *msg = _resultsContrller.fetchedObjects[row];
    
    //TODO 使用XMPPvCardAvatarModule  来获取好友头像
    if ([msg.outgoing boolValue]){//是往外发的，就是自己的
        cellView.contentTextView.string = [NSString stringWithFormat:@"Me:%@", msg.body];
    } else {//别人发的
        cellView.contentTextView.string = [NSString stringWithFormat:@"Other:%@", msg.body];
        cellView.avatarBtn.image = [LYChattingTool sharedLYChattingTool].currentChattingContactModel.photo;
    }
//   cellView.avatarBtn.image =  [NSImage imageNamed:@"LeonCafe"];
    //TODO 聊天内容处理有问题，iMessage发送的消息没有bodyType标签，无法判断是文字还是图片，所以发送的内容需要自己定义通信协议!
    //判断是图片还是纯文本
//    NSString *chatType = [msg.message attributeStringValueForName:@"bodyType"];
//    if ([chatType isEqualToString:@"image"]) {
//        //下图片显示
//        cellView.imageView = nil ;
//    } else if ([chatType isEqualToString:@"text"]) {
//        //显示消息
//        if ([msg.outgoing boolValue]){//是往外发的，就是自己的
//            cellView.textField.stringValue = [NSString stringWithFormat:@"%ld Me:%@",row, msg.body];
//        } else {//别人发的
//            cellView.textField.stringValue = [NSString stringWithFormat:@"%ld Me:%@",row, msg.body];
//        }
//        cellView.imageView.image = nil;
//    }
    return  cellView;
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    _resultsContrller = controller;//更新数据源
    //刷新数据
    [self.chattingTableView reloadData];
    
    [self scrollToTableBottom];
}


#pragma mark - NSTextViewDelegate

//当text内容发生变化时调用，拖拽文件到text对象时也会调用，若返回YES则变化有效，若返回NO则text对象禁止编辑操作
- (BOOL)textShouldBeginEditing:(NSText *)textObject {
    return YES;
}

//textview失去焦点时调用，若返回YES就结束编辑，若返回NO就选中所有text内容，仍是第一响应者
- (BOOL)textShouldEndEditing:(NSText *)textObject {
    return YES;
}

//每次选中textview时会调用
- (void)textViewDidChangeSelection:(NSNotification *)notification {
}

//开始编辑时调用，输入第一个字符时响应，notification的object中可以获取到NSText对象，从中获取文字内容
- (void)textDidBeginEditing:(NSNotification *)notification {
}


// 鼠标移开textview失去焦点时调用，返回YES就结束编辑
- (void)textDidEndEditing:(NSNotification *)notification {
}

- (void)textDidChange:(NSNotification *)notification {
    NSText *text = notification.object;
    NSString *textContent = text.string;
    //若输入文字中包含换行符，表示已经按下Enter键，此时发送消息
    NSString *realMsg = [text.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([textContent containsString:@"\n"] && realMsg.length > 0) {
        [self sendMsgWithText:realMsg bodyType:@"text"];
        //发送后清空输入内容
        self.textView.string = @"" ;
    }
}

//发送图片
//基本思路：先将图片上传到服务器地址，获取服务器图片的URL，然后将此图片url作为文本发送，对方接受后，根据url获得图片
- (void)sendImageWith:(NSImage *)image {
    //1 取文件名：用户名+时间(20170317)年月日时分秒
    NSString *user = [LYUserInfo sharedLYUserInfo].user;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *timeStr = [dateFormatter stringFromDate:[NSDate date]];
    
    //
    NSString *fileName = [user stringByAppendingString:timeStr];
    NSString *uploadUrl = GetImageUploadURLWith(fileName);
    NSData *imageData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    
    NSDictionary *imageProps = nil;
    NSNumber *quality = [NSNumber numberWithFloat:.85];
    
    imageProps = [NSDictionary dictionaryWithObject:quality forKey:NSImageCompressionFactor];
    NSData *imageDataToSend = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    
    [self.httpTool uploadData:imageDataToSend
                          url:[NSURL URLWithString:uploadUrl]
                progressBlock:^(CGFloat progress) {
    }
                   completion:^(NSError *error) {
                       if (!error) {
                           [self sendMsgWithText:uploadUrl bodyType:@"image"];
                       }
    }];
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

#pragma mark - Send Message
#pragma mark - 发送文本消息
- (void)sendMsgWithText:(NSString *)text bodyType:(NSString *)bodyTyep {
    XMPPMessage *msg = [XMPPMessage messageWithType:@"chat" to:[LYChattingTool sharedLYChattingTool].currentChattingContactModel.jid];
    
    //text纯文本
    //image 图片
    [msg addAttributeWithName:@"bodyType" stringValue:bodyTyep];
    //设置内容
    [msg addBody:text];
    
    LYLog(@"msg = %@",msg);
    
    [[LYXMPPTool sharedLYXMPPTool].xmppStream sendElement:msg];
}

@end
