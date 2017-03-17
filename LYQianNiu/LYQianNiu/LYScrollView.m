

//
//  LYScrollView.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/17.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYScrollView.h"

@interface LYScrollView ()
@property (nonatomic, strong) NSView *viewShouldAcceptScrollEvent;//缓存应该处理滚动事件的对象
@end

@implementation LYScrollView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

#pragma mark - Event 
//将滚动事件丢给上一个NSTableView处理
//这里是为了防止聊天列表中，鼠标在聊天气泡的textview区时，滚动时间被textview获取
//这里的处理是，textview的scrollview使用这个类，然后在这里将滚动事件传递到上一个tableview，也就是聊天列表处理
- (void)scrollWheel:(NSEvent *)event {
    [self.viewShouldAcceptScrollEvent scrollWheel:event];
}

#pragma mark - Lazy Loading

- (NSView *)viewShouldAcceptScrollEvent {
    if (!_viewShouldAcceptScrollEvent) {
        _viewShouldAcceptScrollEvent = [self getSuperViewOfView:self WithClassName:@"NSTableView"];
    }
    return _viewShouldAcceptScrollEvent;
}

#pragma mark - Private

- (NSView *)getSuperViewOfView:(NSView *)aView WithClassName:(NSString *)className  {
    while (![[aView className] isEqualToString:className]) {
        aView = aView.superview;
    }
    return aView;
}

@end
