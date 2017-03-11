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
    // Do view setup here.
}

- (IBAction)fileTransferBtnClicked:(id)sender {
}

- (IBAction)addContactsBtnClicked:(id)sender {
}

- (IBAction)foldRightViewBtnClicked:(id)sender {
}

@end
