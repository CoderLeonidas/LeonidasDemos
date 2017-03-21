//
//  LYTopAreaViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYTopAreaViewController.h"

@interface LYTopAreaViewController ()
@property (weak) IBOutlet NSTextField *nameAndStatusTextField;//名字和在线状态
@property (weak) IBOutlet NSTextField *mottoTextField;//签名(说说)
@property (weak) IBOutlet NSButton *fileTransferBtn;//文件传输
@property (weak) IBOutlet NSButton *addContactsBtn;//添加联系人
@property (weak) IBOutlet NSButton *foldRightViewBtn;//右边视图折叠

@end

@implementation LYTopAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshContent) name:LYContactRowSelectionDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

- (void)refreshContent {
    XMPPUserCoreDataStorageObject *model = [LYChattingTool sharedLYChattingTool].currentChattingContactModel;

    [[LYXMPPTool sharedLYXMPPTool] loadPhotoForUser:model];
    NSString *status = @"";
    switch ([model.sectionNum intValue]) {//好友状态
        case 0:
            status = @"在线";
            break;
        case 1:
            status = @"离开";
            break;
        case 2:
            status = @"离线";
            break;
        default:
            break;
    }
    NSString *nameAndStatusStr = [NSString stringWithFormat:@"%@:%@ [%@]",model.displayName, model.nickname, status];
    self.nameAndStatusTextField.stringValue = nameAndStatusStr;
    
    NSString *mottoStr = @"啊啊啊啊";
    self.mottoTextField.stringValue = mottoStr;
}


#pragma mark - IBAction

- (IBAction)fileTransferBtnClicked:(id)sender {
}

- (IBAction)addContactsBtnClicked:(id)sender {
}

- (IBAction)foldRightViewBtnClicked:(id)sender {
}

@end
