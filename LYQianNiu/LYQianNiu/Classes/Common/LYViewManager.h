//
//  LYViewManager.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/9.
//  Copyright © 2017年 Leon. All rights reserved.
//

//这是一个视图管理器，用于管理多个视图，根据需要将子视图显示在父视图上，并移除其他的视图

#import <Foundation/Foundation.h>

@interface LYViewManager : NSObject

/**
 供外部设置交给LYViewManager管理的视图控制器键值对

 @param keysAndVCs 视图控制器键值对
 */
- (void)setKeysAndVCs:(NSDictionary *)keysAndVCs ;

/**
 供外部设置宿主视图

 @param hostingView 宿主视图
 */
- (void)setHostingView:(NSView *)hostingView;

/**
 显示key对应的视图

 @param key 视图的key
 */
- (void)showViewWithKey:(long)key;

@end
