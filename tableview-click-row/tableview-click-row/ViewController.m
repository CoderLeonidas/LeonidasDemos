//
//  ViewController.m
//  tableview-click-row
//
//  Created by Leonidas on 2017/4/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.tableColumns[0].title = @"data";
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 100;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    static NSString *identifier = @"ID";
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    if (!cellView) {
        cellView = [[NSTableCellView alloc] init];
        cellView.identifier = identifier;
        cellView.frame = NSMakeRect(0, 0, tableColumn.width, tableView.rowHeight);
    }
   //cellView加入一个button后，可以通过button来捕获点击事件，在此执行一些我们自己的逻辑
    NSButton *btn = [[NSButton alloc] initWithFrame:cellView.bounds];
    btn.bezelStyle = NSBezelStyleRoundRect;
    btn.bordered = NO;
    btn.wantsLayer = YES;
    btn.title = @"";
    btn.layer.backgroundColor = [NSColor clearColor].CGColor;
    [btn setTarget:self];
    [btn setAction:@selector(rowClicked)];
    [cellView addSubview:btn];
    
    return cellView;
}

- (void)rowClicked {
    NSLog(@"row Clicked");
}



@end
