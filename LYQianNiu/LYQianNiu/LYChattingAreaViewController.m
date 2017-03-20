//
//  LYChattingAreaViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/12.
//  Copyright © 2017年 Leon. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "LYChattingAreaViewController.h"
#import "LYChattingCell.h"
#import "LYChattingCellModel.h"

#import "LYChattingCellFrame.h"
#import "NSImage+WebCache.h"

#import "LYHttpTool.h"
#import "SnipManager.h"

@interface LYChattingAreaViewController () <NSSplitViewDelegate, NSTableViewDelegate, NSTableViewDataSource,NSFetchedResultsControllerDelegate, NSTextViewDelegate> {
    
    NSFetchedResultsController *_resultsContrller;//操作CoreData获取消息
    
    NSImageView *_backImageView;
    
    NSArray <LYChattingCellFrame*> *_dataSource;//数据源
    
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

#pragma mark - Init

- (void) initObjects {
    self.chattingTableView.delegate = self;
    self.chattingTableView.dataSource = self;
    self.textView.delegate = self;
    
    _dataSource = @[];
}

#pragma mark - Notification

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshChattingMessage) name:LYContactRowSelectionDidChangeNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEndCapture:) name:kNotifyCaptureEnd object:nil];
}

#pragma mark - Snap

- (void)onEndCapture:(NSNotification *)notification {
    if (notification.userInfo[@"image"]) {
        NSImage *image = notification.userInfo[@"image"];
        [image setName:[NSString stringWithFormat:@"snip_%lf.png", [NSDate date].timeIntervalSinceReferenceDate]];
        [self showImage:image toTextView:self.textView];
        return;
    }
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
    
    _dataSource = [self getDataSourceFromFetchedResultsController:_resultsContrller];
    if (err) {
        LYLog(@"%@", err);
    }
}

#pragma mark - IBAction

- (IBAction)emojiBtnClicked:(id)sender {
}

- (IBAction)screenshotBtnClicked:(id)sender {
    [[SnipManager sharedInstance] startCapture];
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
                NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];
                [self showImage:image toTextView:self.textView];
            }
        }
    }];
}

//将图片以属性文字的形式显示在textview上(支持图文混排)
- (void)showImage:(NSImage *)image toTextView:(NSTextView *)textView {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    NSFileWrapper *imageFileWrapper = [[NSFileWrapper alloc] initRegularFileWithContents:[image TIFFRepresentation]];
    imageFileWrapper.filename = image.name;
    imageFileWrapper.preferredFilename = image.name;
    NSTextAttachment *imageAttachment = [[NSTextAttachment alloc] initWithFileWrapper:imageFileWrapper] ;
    NSAttributedString *imageAttributedString = [NSAttributedString attributedStringWithAttachment:imageAttachment];
    [attributedString insertAttributedString:imageAttributedString atIndex:0];
    [textView insertText:attributedString];
}

- (IBAction)sharkScreenBtnClicked:(id)sender {
//    [self shakeAnimationForView:self.view.window.contentView];
    [self shakeScreen];
}

- (void)shakeScreen{
    static int numberOfShakes = 3;
    static float durationOfShake = 0.3f;
    static float vigourOfShake = 0.02f;
    CGRect frame=[self.view.window frame];
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animation];
    
    CGMutablePathRef shakePath = CGPathCreateMutable();
    CGPathMoveToPoint(shakePath, NULL, NSMinX(frame), NSMinY(frame));
    int index;
    for (index = 0; index < numberOfShakes; ++index)
    {
        CGPathAddLineToPoint(shakePath, NULL, NSMinX(frame) - frame.size.width * vigourOfShake, NSMinY(frame));
        CGPathAddLineToPoint(shakePath, NULL, NSMinX(frame) + frame.size.width * vigourOfShake, NSMinY(frame));
    }
    CGPathCloseSubpath(shakePath);
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = durationOfShake;
    
    [self.view.window setAnimations:[NSDictionary dictionaryWithObject: shakeAnimation forKey:@"frameOrigin"]];
    [[self.view.window animator] setFrameOrigin:[self.view.window frame].origin];
    
}

- (void)shakeAnimationForView:(NSView *)view { // 获取到当前的View
    CALayer *viewLayer = view.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x -5, position.y +5);
    CGPoint y = CGPointMake(position.x +5, position.y-5);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:.06];
    // 设置次数
    [animation setRepeatCount:8];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}

- (IBAction)reportBtnClicked:(id)sender {
    
}

- (IBAction)quickReplyBtnClicked:(id)sender {
}

- (IBAction)chattingRecordBtnClicked:(id)sender {
}

#pragma mark - Lazy Loading

- (LYHttpTool*) httpTool{
    if (!_httpTool) {
        _httpTool = [[LYHttpTool alloc] init];
    }
    return _httpTool;
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
    return _dataSource.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    LYChattingCellFrame *cellFrame = _dataSource[row];
    return cellFrame.cellHeight;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    LYChattingCell *cellView = [LYChattingCell cellWithTableView:tableView];
    cellView.cellFrame = _dataSource[row];
//    NSString *identifier = NSStringFromClass([LYChattingCell class]);
//    LYChattingCell *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
//    if (!cellView) {
//        cellView = [[LYChattingCell alloc]init];
//        cellView.identifier = identifier;
//    }
//    LYChattingCellModel *model = _dataSource[row];
//    cellView.cellWidth = tableView.tableColumns[0].width;
//    cellView.model = model;
    
    
    //TODO 使用XMPPvCardAvatarModule  来获取好友头像
//    if (model.outgoing){//是往外发的，就是自己的
//        cellView.contentTextView.string = [NSString stringWithFormat:@"Me:%@", msg.body];
//    } else {//别人发的
//        cellView.contentTextView.string = [NSString stringWithFormat:@"Other:%@", msg.body];
//        cellView.avatarBtn.image = [LYChattingTool sharedLYChattingTool].currentChattingContactModel.photo;
//    }
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
    
    _dataSource = [self getDataSourceFromFetchedResultsController:controller];
    //刷新数据
    [self.chattingTableView reloadData];
    
    [self scrollToTableBottom];
}

- (NSArray *)getDataSourceFromFetchedResultsController:(NSFetchedResultsController *)controller {
    if (controller.fetchedObjects.count == 0) return nil;
    if (![controller.fetchedObjects[0] isKindOfClass:[XMPPMessageArchiving_Message_CoreDataObject class]]) return nil;
    NSMutableArray *result = [NSMutableArray array];
    for (XMPPMessageArchiving_Message_CoreDataObject *obj in controller.fetchedObjects) {
        LYChattingCellModel *cellModel = [[LYChattingCellModel alloc] init];
        cellModel.avatar = [NSImage imageNamed:@"LeonCafe"];
        cellModel.message = obj.message.body;
        cellModel.outgoing = [obj.outgoing boolValue];
        cellModel.timeStamp = obj.timestamp;
        LYChattingCellFrame *cellFrame = [[LYChattingCellFrame alloc] init];
        [cellFrame setCellWidth:self.chattingTableView.tableColumns[0].width];
        cellFrame.cellModel = cellModel;
        [result addObject:cellFrame];
    }
    return [NSArray arrayWithArray:result];
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
    [self.chattingTableView scrollRowToVisible:lastRow];
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
