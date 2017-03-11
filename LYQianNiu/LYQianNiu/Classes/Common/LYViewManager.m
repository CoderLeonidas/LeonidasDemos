//
//  LYViewManager.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/9.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYViewManager.h"

@interface LYViewManager ()  {
    NSViewController *_currentVC;//当前的视图
    long _keyForCurrentView;//当前是视图的key
}

@property (nonatomic, copy) NSDictionary *keysAndVCs;//所有视图的字典
@property (nonatomic, strong) NSView *hostingView;//宿主视图
@end
@implementation LYViewManager
@synthesize keysAndVCs = _keysAndVCs;

#pragma mark - Getter & Setter

- (void)setKeysAndVCs:(NSDictionary *)keysAndVCs {
    if (!keysAndVCs) return;
    
    _keysAndVCs = keysAndVCs;
}

- (NSDictionary *)keysAndVCs {
    return _keysAndVCs;
}

- (void)setHostingView:(NSView *)hostingView {
    if (!hostingView || [hostingView isEqual:_hostingView]) return;
    
    _hostingView = hostingView;
}

#pragma mark - Public

- (void)showViewWithKey:(long)key {
    if (key == _keyForCurrentView)  return;
    //移除旧视图
    if (_currentVC.view.superview) {
        [_currentVC.view removeFromSuperview];
    }
     //添加新视图
    _keyForCurrentView = key;
    _currentVC = self.keysAndVCs[@(key)];
    if (_currentVC.view) {
        _currentVC.view.frame = self.hostingView.bounds;
         [self.hostingView addSubview:_currentVC.view positioned:NSWindowAbove relativeTo:nil];
    }
}

@end
