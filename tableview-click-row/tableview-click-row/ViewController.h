//
//  ViewController.h
//  tableview-click-row
//
//  Created by Leonidas on 2017/4/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>
@property (weak) IBOutlet NSTableView *tableview;


@end

