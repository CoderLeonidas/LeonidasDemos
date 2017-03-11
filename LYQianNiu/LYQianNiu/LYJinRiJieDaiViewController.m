//
//  LYJinRiJieDaiViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/9.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYJinRiJieDaiViewController.h"

@interface LYLianXiRenEntity: NSObject

@end

@interface LYJinRiJieDaiViewController () <NSTableViewDelegate, NSTableViewDataSource> {

    NSMutableArray *_dataSource;
}

@end

@implementation LYJinRiJieDaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)initObjects {
    _dataSource = [NSMutableArray array];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _dataSource.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 20.0;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {

}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    return nil;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return nil;
}

@end
