//
//  LYLeftViewContainer.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/8.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYLeftViewContainer.h"
#import "LYImageTextField.h"

#import "Masonry.h"
@interface LYLeftViewContainer ()
@property (weak) IBOutlet NSView *topView;
@property (weak) IBOutlet NSView *bottomView;

@property (nonatomic, strong) LYImageTextField *searchBar;

@end

@implementation LYLeftViewContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [TestCode changeBGColor:[NSColor yellowColor] inView:self.bottomView];
    [TestCode changeBGColor:[NSColor greenColor] inView:self.topView];
    [self setupSearchBar];

    
}

#define PaddingTopBottom 20
#define PaddingLeftRight 20
- (void)setupSearchBar {
    CGFloat w = self.view.frame.size.width - 2 * PaddingLeftRight;
    CGFloat h = self.view.frame.size.height - 2 * PaddingTopBottom;
    CGFloat x = PaddingLeftRight;
    CGFloat y = PaddingTopBottom;
//    self.searchBar.view.frame = NSMakeRect(x, y, w, h);
    self.searchBar.image = [NSImage imageNamed:@"appIcon_32x32@2x"];
    [self.topView addSubview:self.searchBar.view];
}

- (LYImageTextField *)searchBar {
    if (!_searchBar) {
        _searchBar = [[LYImageTextField alloc] initWithNibName:@"LYImageTextField" bundle:nil];
    }
    return _searchBar;
}

@end
